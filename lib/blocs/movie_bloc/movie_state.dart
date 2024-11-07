part of 'movie_bloc.dart';

class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoadSuccess extends MovieState {
  final List<Movie> movies;

  MovieLoadSuccess({required this.movies});
}

class MovieLoadFailure extends MovieState {
  final String message;

  MovieLoadFailure({required this.message});
}

class MovieLoading extends MovieState {}

