import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/models/tv_show/tv_show.dart';
import 'package:movie_nest_app/repositories/tv_show_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';
part 'tv_show_event.dart';
part 'tv_show_state.dart';

class TvShowBloc extends Bloc<TvShowEvent, TvShowState> {
  int currentPage = 0;
  int _totalPage = 1;
  List<TvShow> allTvShows = [];
  bool isLoadingInProgress = false;

  TvShowBloc() : super(TvShowInitial()) {
    on<LoadTvShows>((event, emit) async {
      if (isLoadingInProgress || currentPage >= _totalPage) return;
      try {
        isLoadingInProgress = true;
        if (currentPage == 0) emit(TvShowLoading());
        final nextPage = currentPage + 1;
        final popularTvShowsResponse =
            await GetIt.I<TvShowRepository>().getPopularTvShows(nextPage);
        allTvShows.addAll(popularTvShowsResponse.tvShows);
        currentPage = popularTvShowsResponse.page;
        _totalPage = popularTvShowsResponse.totalPages;
        emit(TvShowLoadSuccess(tvShows: allTvShows));
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
        if (currentPage == 0) {
          emit(TvShowLoadFailure(
              message: 'Something went wrong, try again later'));
        }
      } finally {
        isLoadingInProgress = false;
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
