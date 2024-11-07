part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchResultsIsLoading extends SearchState {}

class ResultsLoadSuccess extends SearchState {
  final List<Movie> movies;
  
  
  ResultsLoadSuccess({
    required this.movies,
   
  });
}

class ResultsLoadFailure extends SearchState {
  final String message;

  ResultsLoadFailure({required this.message});
}

class SearchQueryCleared extends SearchState {}
