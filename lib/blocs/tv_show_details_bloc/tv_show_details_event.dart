part of 'tv_show_details_bloc.dart';

abstract class TvShowDetailsEvent {}

class LoadTvShowDetails extends TvShowDetailsEvent {
  final int tvShowId;

  LoadTvShowDetails({required this.tvShowId});
}
