part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchMovies extends SearchEvent {
  final String query;

  SearchMovies({required this.query});
}

class LoadNextPage extends SearchEvent {
}

class ClearSearchQuery extends SearchEvent {}

class ReturnToInitial extends SearchEvent{}
