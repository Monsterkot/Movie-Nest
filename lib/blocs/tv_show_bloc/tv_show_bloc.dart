import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/models/popular_tv_show_response/popular_tv_show_response.dart';
import 'package:movie_nest_app/models/tv_show/tv_show.dart';
import 'package:movie_nest_app/repositories/tv_show_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';
part 'tv_show_event.dart';
part 'tv_show_state.dart';

class TvShowBloc extends Bloc<TvShowEvent, TvShowState> {
  int _currentPage = 0;
  int _totalPage = 1;
  final List<TvShow> _allTvShows = [];
  bool isLoadingInProgress = false;
  String? _searchQuery;

  TvShowBloc() : super(TvShowInitial()) {
    on<SearchTvShows>((event, emit) async {
      await _searchMovies(event.query, emit);
    });
    on<LoadTvShows>((event, emit) async {
      await _loadNextPage(emit, tvShowsAreFavorite: false);
    });
    on<ClearSearchQuery>((event, emit) async {
      _searchQuery = null;
      await _resetList(emit);
    });
    on<LoadTvShowLists>((event, emit) async {
      await _loadTvShowLists(event.filter, emit);
    });
    on<LoadFavoriteTvShows>((event, emit) async {
      await _loadNextPage(emit, tvShowsAreFavorite: true);
    });
  }

  Future<void> _loadTvShowLists(String filter, Emitter<TvShowState> emit) async {
    emit(TvShowLoading());
    try {
      switch (filter) {
        case 'Airing Today':
          final airingTodayTvShows = await GetIt.I<TvShowRepository>().getAiringTodayTvShows();
          emit(TvShowLoadSuccess(tvShows: airingTodayTvShows.tvShows));
          break;
        case 'Top Rated':
          final topRatedTvShows = await GetIt.I<TvShowRepository>().getTopRatedTvShows();
          emit(TvShowLoadSuccess(tvShows: topRatedTvShows.tvShows));
          break;
        case 'On The Air':
          final onTheAirTvShows = await GetIt.I<TvShowRepository>().getOnTheAirTvShows();
          emit(TvShowLoadSuccess(tvShows: onTheAirTvShows.tvShows));
          break;
        case 'Popular':
          final popularTvShows = await GetIt.I<TvShowRepository>().getPopularTvShows(1);
          emit(TvShowLoadSuccess(tvShows: popularTvShows.tvShows));
          break;
        default:
          GetIt.I<Talker>().error('Unknown movie filter.');
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      emit(TvShowLoadFailure(message: 'Something went wrong, try again later'));
    }
  }

  Future<void> _resetList(Emitter<TvShowState> emit) async {
    _currentPage = 0;
    _totalPage = 1;
    _allTvShows.clear();
    await _loadNextPage(emit, tvShowsAreFavorite: false);
  }

  Future<void> _searchMovies(String query, Emitter<TvShowState> emit) async {
    _searchQuery = query.isNotEmpty ? query : null;
    await _resetList(emit);
  }

  Future<TvShowResponse> _loadTvShows(int nextPage, bool tvShowsAreFavorite) async {
    if (tvShowsAreFavorite) {
      return await GetIt.I<TvShowRepository>().getFavoriteTvShows(nextPage);
    }
    final query = _searchQuery;
    if (query == null) {
      return await GetIt.I<TvShowRepository>().getPopularTvShows(nextPage);
    } else {
      return await GetIt.I<TvShowRepository>().getTvShowsByQuery(query, nextPage);
    }
  }

  Future<void> _loadNextPage(Emitter<TvShowState> emit, {required bool tvShowsAreFavorite}) async {
    if (isLoadingInProgress || _currentPage >= _totalPage) return;
    try {
      isLoadingInProgress = true;
      if (_currentPage == 0) emit(TvShowLoading());
      final nextPage = _currentPage + 1;

      final tvShowResponse = await _loadTvShows(nextPage, tvShowsAreFavorite);
      if (tvShowResponse.page == 1 && nextPage >= 2) return;
      
      _allTvShows.addAll(tvShowResponse.tvShows);
      _currentPage = tvShowResponse.page;
      _totalPage = tvShowResponse.totalPages;

      if (_searchQuery != null) {
        emit(TvShowsByQueryLoadSuccess(tvShows: _allTvShows));
      } else {
        emit(TvShowLoadSuccess(tvShows: _allTvShows));
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      if (_currentPage == 0) {
        emit(TvShowLoadFailure(message: 'Something went wrong, try again later'));
      }
    } finally {
      isLoadingInProgress = false;
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
