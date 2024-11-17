part of 'movie_bloc.dart';

class MovieEvent {}

class LoadMovies extends MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;

  SearchMovies({required this.query});
}

class ClearSearchQuery extends MovieEvent {}

