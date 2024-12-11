import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/models/popular_tv_show_response/popular_tv_show_response.dart';
import 'package:movie_nest_app/models/tv_show_details/tv_show_details.dart';
import 'package:movie_nest_app/services/tv_show_service.dart';

class TvShowRepository {
  Future<PopularTvShowResponse> getPopularTvShows(int page) async {
    final json = await GetIt.I<TvShowService>().getPopularTvShows(page);
    final popularTvShows = PopularTvShowResponse.fromJson(json);
    return popularTvShows;
  }

  Future<PopularTvShowResponse> getAiringTodayTvShows() async {
    final json = await GetIt.I<TvShowService>().getAiringTodayTvShows();
    final airingTodayTvShows = PopularTvShowResponse.fromJson(json);
    return airingTodayTvShows;
  }

  Future<PopularTvShowResponse> getOnTheAirTvShows() async {
    final json = await GetIt.I<TvShowService>().getOnTheAirTvShows();
    final onTheAirTvShows = PopularTvShowResponse.fromJson(json);
    return onTheAirTvShows;
  }

  Future<PopularTvShowResponse> getTopRatedTvShows() async {
    final json = await GetIt.I<TvShowService>().getTopRatedTvShows();
    final topRatedTvShows = PopularTvShowResponse.fromJson(json);
    return topRatedTvShows;
  }

  Future<TvShowDetails> getTvShowDetails(int tvShowId) async {
    final json = await GetIt.I<TvShowService>().getTvShowDetails(tvShowId);
    final tvShowDetails = TvShowDetails.fromJson(json);
    return tvShowDetails;
  }

  Future<PopularTvShowResponse> getTvShowsByQuery(String query, int page) async {
    final json = await GetIt.I<TvShowService>().getTvShowsByQuery(query, page);
    final tvShowsByQuery = PopularTvShowResponse.fromJson(json);
    return tvShowsByQuery;
  }
}
