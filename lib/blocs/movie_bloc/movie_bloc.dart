import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/repositories/movie_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../models/movie/movie.dart';
part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  int currentPage = 0;
  int _totalPage = 1;
  List<Movie> allMovies = [];
  bool isLoadingInProgress = false;

  MovieBloc() : super(MovieInitial()) {
    on<LoadMovies>((event, emit) async {
      if (isLoadingInProgress || currentPage >= _totalPage) return;
      try {
        isLoadingInProgress = true;
        if (currentPage == 0) emit(MovieLoading());
        final nextPage = currentPage + 1;
        final popularMoviesResponse =
            await GetIt.I<MovieRepository>().getPopularMovies(nextPage);
        allMovies.addAll(popularMoviesResponse.movies);
        currentPage = popularMoviesResponse.page;
        _totalPage = popularMoviesResponse.totalPages;
        emit(MovieLoadSuccess(movies: allMovies));
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
        if (currentPage == 0) {
          emit(MovieLoadFailure(
              message: 'Something went wrong, try again later'));
        }
      } finally {
        isLoadingInProgress = false;
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
