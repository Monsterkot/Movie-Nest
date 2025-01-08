import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/repositories/movie_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../models/movie/movie.dart';
import '../../models/movie_response/movie_response.dart';
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
    on<LoadPopularMovies>((event, emit) async {
      await _loadNextPage(emit, moviesAreFavorite: false);
    });
    on<ClearSearchQuery>((event, emit) async {
      _searchQuery = null;
      await _resetList(emit);
    });
    on<LoadMovieLists>((event, emit) async {
      await _loadMovieLists(event.filter, emit);
    });
    on<LoadFavoriteMovies>((event, emit) async {
      await _loadNextPage(emit, moviesAreFavorite: true);
    });
  }

  Future<void> _loadMovieLists(String filter, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      switch (filter) {
        case 'Now Playing':
          final nowPlayingMovies = await GetIt.I<MovieRepository>().getNowPlayingMovies();
          emit(MovieLoadSuccess(movies: nowPlayingMovies.movies));
          break;
        case 'Top Rated':
          final topRatedMovies = await GetIt.I<MovieRepository>().getTopRatedMovies();
          emit(MovieLoadSuccess(movies: topRatedMovies.movies));
          break;
        case 'Upcoming':
          final upcomingMovies = await GetIt.I<MovieRepository>().getUpcomingMovies();
          emit(MovieLoadSuccess(movies: upcomingMovies.movies));
          break;
        case 'Popular':
          final popularMovies = await GetIt.I<MovieRepository>().getPopularMovies(1);
          emit(MovieLoadSuccess(movies: popularMovies.movies));
          break;
        default:
          GetIt.I<Talker>().error('Unknown movie filter.');
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      emit(MovieLoadFailure(message: 'Something went wrong, try again later'));
    }
  }

  Future<void> _resetList(Emitter<MovieState> emit) async {
    _currentPage = 0;
    _totalPage = 1;
    _allMovies.clear();
    await _loadNextPage(emit, moviesAreFavorite: false);
  }

  Future<void> _searchMovies(String query, Emitter<MovieState> emit) async {
    _searchQuery = query.isNotEmpty ? query : null;
    await _resetList(emit);
  }

  Future<MovieResponse> _loadMovies(int nextPage, bool moviesAreFavorite) async {
    if (moviesAreFavorite) {
      return await GetIt.I<MovieRepository>().getFavoriteMovies(nextPage);
    }
    final query = _searchQuery;
    if (query == null) {
      return await GetIt.I<MovieRepository>().getPopularMovies(nextPage);
    } else {
      return await GetIt.I<MovieRepository>().getMoviesByQuery(query, nextPage);
    }
  }

  Future<void> _loadNextPage(Emitter<MovieState> emit, {required bool moviesAreFavorite}) async {
    if (isLoadingInProgress || _currentPage >= _totalPage) return;
    try {
      isLoadingInProgress = true;
      if (_currentPage == 0) emit(MovieLoading());
      final nextPage = _currentPage + 1;

      final moviesResponse = await _loadMovies(nextPage, moviesAreFavorite);

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
        emit(MovieLoadFailure(message: 'Something went wrong, try again later'));
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
