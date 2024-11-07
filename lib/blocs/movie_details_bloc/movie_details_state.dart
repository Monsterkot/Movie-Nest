part of 'movie_details_bloc.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState{

}

class MovieDetailsLoadSuccess extends MovieDetailsState {
  final MovieDetails movieDetails;

  MovieDetailsLoadSuccess({required this.movieDetails});
}

class MovieDetailsLoadFailure extends MovieDetailsState {
  final String message;

  MovieDetailsLoadFailure({required this.message});
}
