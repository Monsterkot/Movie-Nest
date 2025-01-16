import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/models/popular_tv_show_response/popular_tv_show_response.dart';
import 'package:movie_nest_app/models/tv_show_details/tv_show_details.dart';
import 'package:movie_nest_app/services/tv_show_service.dart';

import '../constants/media_type.dart';

class TvShowRepository {
  Future<TvShowResponse> getPopularTvShows(int page) async {//TODO cache
    final json = await GetIt.I<TvShowService>().getPopularTvShows(page);
    final popularTvShows = TvShowResponse.fromJson(json);
    return popularTvShows;
  }

  Future<TvShowResponse> getAiringTodayTvShows() async {//TODO cache
    final json = await GetIt.I<TvShowService>().getAiringTodayTvShows();
    final airingTodayTvShows = TvShowResponse.fromJson(json);
    return airingTodayTvShows;
  }

  Future<TvShowResponse> getOnTheAirTvShows() async {//TODO cache
    final json = await GetIt.I<TvShowService>().getOnTheAirTvShows();
    final onTheAirTvShows = TvShowResponse.fromJson(json);
    return onTheAirTvShows;
  }

  Future<TvShowResponse> getTopRatedTvShows() async {//TODO cache
    final json = await GetIt.I<TvShowService>().getTopRatedTvShows();
    final topRatedTvShows = TvShowResponse.fromJson(json);
    return topRatedTvShows;
  }

  Future<TvShowDetails> getTvShowDetails(int tvShowId) async {
    final json = await GetIt.I<TvShowService>().getTvShowDetails(tvShowId);
    final tvShowDetails = TvShowDetails.fromJson(json);
    return tvShowDetails;
  }

  Future<TvShowResponse> getTvShowsByQuery(String query, int page) async {
    final json = await GetIt.I<TvShowService>().getTvShowsByQuery(query, page);
    final tvShowsByQuery = TvShowResponse.fromJson(json);
    return tvShowsByQuery;
  }

  Future<bool> isFavorite(int movieId) async {
    final json = await GetIt.I<TvShowService>().isFavorite(movieId);
    final isFavorite = json['favorite'] as bool;
    return isFavorite;
  }

  Future<void> toggleFavorite({required int tvShowId, required bool isLiked}) async {
    await GetIt.I<TvShowService>()
        .markAsFavorite(mediaType: MediaType.tv, mediaId: tvShowId, isFavorite: isLiked);
  }

  Future<TvShowResponse> getFavoriteTvShows(int page) async {
    final json = await GetIt.I<TvShowService>().getFavoriteTvShows(page);
    final favoriteTvShows = TvShowResponse.fromJson(json);
    return favoriteTvShows;
  }
}
