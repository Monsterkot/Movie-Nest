import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/models/movie_details/movie_details.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../repositories/movie_repository.dart';
part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc() : super(MovieDetailsInitial()) {
    on<LoadMovieDetails>((event, emit) async {
      try {
        emit(MovieDetailsLoading());
        final movieDetails = await GetIt.I<MovieRepository>().getMovieDetails(event.movieId);
        final isMovieFavorite = await GetIt.I<MovieRepository>().isFavorite(event.movieId);
        emit(MovieDetailsLoadSuccess(
          movieDetails: movieDetails,
          isMovieFavorite: isMovieFavorite,
        ));
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
        emit(MovieDetailsLoadFailure());
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
