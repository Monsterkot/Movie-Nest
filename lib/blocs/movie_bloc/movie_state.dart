part of 'movie_bloc.dart';

class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoadSuccess extends MovieState {
  final List<Movie> movies;

  MovieLoadSuccess({required this.movies});
}

class MoviesByQueryLoadSuccess extends MovieState {
  final List<Movie> movies;

  MoviesByQueryLoadSuccess({required this.movies});
}

class MovieLoadFailure extends MovieState {
}

class MovieLoading extends MovieState {}
