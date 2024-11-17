import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/repositories/movie_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../models/movie/movie.dart';
import '../../models/popular_movie_response/popular_movie_response.dart';
part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  int _currentPage = 0;
  int _totalPage = 1;
  final List<Movie> _allMovies = [];
  bool isLoadingInProgress = false;
  String? _searchQuery;

  MovieBloc() : super(MovieInitial()) {
    on<SearchMovies>((event, emit) async {
      await _searchMovies(event.query, emit);
    });
    on<LoadMovies>((event, emit) async {
      await _loadNextPage(emit);
    });
    on<ClearSearchQuery>((event, emit) async {
      _searchQuery = null;
      await _resetList(emit);
    });
  }

  Future<void> _resetList(Emitter<MovieState> emit) async {
    _currentPage = 0;
    _totalPage = 1;
    _allMovies.clear();
    await _loadNextPage(emit);
  }

  Future<void> _searchMovies(String query, Emitter<MovieState> emit) async {
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

  Future<void> _loadNextPage(Emitter<MovieState> emit) async {
    if (isLoadingInProgress || _currentPage >= _totalPage) return;
    try {
      isLoadingInProgress = true;
      if (_currentPage == 0) emit(MovieLoading());
      final nextPage = _currentPage + 1;

      final moviesResponse = await _loadMovies(nextPage);

      _allMovies.addAll(moviesResponse.movies);
      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;

      if (_searchQuery != null) {
        emit(MoviesByQueryLoadSuccess(movies: _allMovies));
      } else {
        emit(MovieLoadSuccess(movies: _allMovies));
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      if (_currentPage == 0) {
        emit(
            MovieLoadFailure(message: 'Something went wrong, try again later'));
      }
    } finally {
      isLoadingInProgress = false;
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
