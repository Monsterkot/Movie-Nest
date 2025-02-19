import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/repositories/tv_show_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../models/tv_show_details/tv_show_details.dart';
part 'tv_show_details_event.dart';
part 'tv_show_details_state.dart';

class TvShowDetailsBloc extends Bloc<TvShowDetailsEvent, TvShowDetailsState> {
  TvShowDetailsBloc() : super(TvShowDetailsInitial()) {
    on<LoadTvShowDetails>((event, emit) async {
      try {
        emit(TvShowDetailsIsLoading());
        final tvShowDetails = await GetIt.I<TvShowRepository>().getTvShowDetails(event.tvShowId);
        final isTvShowFavorite = await GetIt.I<TvShowRepository>().isFavorite(event.tvShowId);
        emit(TvShowDetailsLoadSuccess(tvShowDetails: tvShowDetails, isTvShowFavorite: isTvShowFavorite));
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
        emit(TvShowDetailsLoadFailure());
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
