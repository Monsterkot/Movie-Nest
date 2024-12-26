part of 'tv_show_details_bloc.dart';

abstract class TvShowDetailsState {}

class TvShowDetailsInitial extends TvShowDetailsState {}

class TvShowDetailsLoadSuccess extends TvShowDetailsState {
  TvShowDetailsLoadSuccess({required this.tvShowDetails, required this.isTvShowFavorite});

  final TvShowDetails tvShowDetails;
  final bool isTvShowFavorite;
}

class TvShowDetailsLoadFailure extends TvShowDetailsState {
  TvShowDetailsLoadFailure({required this.message});

  final String message;
}

class TvShowDetailsIsLoading extends TvShowDetailsState {}
