import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/models/movie/movie.dart';
import 'package:movie_nest_app/models/popular_movie_response/popular_movie_response.dart';
import 'package:movie_nest_app/repositories/movie_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  int _currentPage = 0;
  int _totalPage = 1;
  final List<Movie> _allMovies = [];
  bool isLoadingInProgress = false;
  final movieRepository = GetIt.I<MovieRepository>();
  String? _searchQuery;
  //Emitter<SearchState>? _emit;

  SearchBloc() : super(SearchInitial()) {
    on<SearchMovies>((event, emit) async {
      await _searchMovies(event.query, emit);
    });
    on<LoadNextPage>((event, emit) async {
      await _loadNextPage(emit);
    });
    on<ClearSearchQuery>((event, emit) {
      emit(SearchQueryCleared());
    });
    on<ReturnToInitial>((event, emit) {
      emit(SearchInitial());
    });
  }

  Future<void> _resetList(Emitter<SearchState> emit) async {
    _currentPage = 0;
    _totalPage = 1;
    _allMovies.clear();
    await _loadNextPage(emit);
  }

  Future<void> _searchMovies(String query, Emitter<SearchState> emit) async {
    _searchQuery = query.isNotEmpty ? query : null;
    await _resetList(emit);
  }

  Future<PopularMovieResponse> _loadMovies(int nextPage) async {
    final query = _searchQuery;
    if (query == null) {
      return await GetIt.I<MovieRepository>().getPopularMovies(nextPage);
    } else {
      return await GetIt.I<MovieRepository>().getMoviesByQuery(query, nextPage);
    }
  }

  Future<void> _loadNextPage(Emitter<SearchState> emit) async {
    if (isLoadingInProgress || _currentPage >= _totalPage) return;
    try {
      isLoadingInProgress = true;
      if (_currentPage == 0) emit(SearchResultsIsLoading());
      final nextPage = _currentPage + 1;

      final moviesResponse = await _loadMovies(nextPage);

      _allMovies.addAll(moviesResponse.movies);
      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;

      emit(ResultsLoadSuccess(movies: _allMovies));
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      if (_currentPage == 0) {
        emit(ResultsLoadFailure(
            message: 'Something went wrong, try again later'));
      }
    } finally {
      isLoadingInProgress = false;
    }
  }
}
