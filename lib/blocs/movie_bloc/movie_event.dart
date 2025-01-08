part of 'movie_bloc.dart';

class MovieEvent {}

class LoadPopularMovies extends MovieEvent {}

class LoadMovieLists extends MovieEvent {
  final String filter;

  LoadMovieLists({required this.filter});
  
}

class SearchMovies extends MovieEvent {
  final String query;

  SearchMovies({required this.query});
}

class ClearSearchQuery extends MovieEvent {}

class LoadFavoriteMovies extends MovieEvent {}
