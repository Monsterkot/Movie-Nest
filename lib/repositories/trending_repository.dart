import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/services/trending_service.dart';

import '../models/movie/movie.dart';
import '../models/trending_content/trending_item.dart';
import '../models/tv_show/tv_show.dart';

class TrendingRepository {
  Future<List<TrendingItem>> getAllTrending(String timeWindow) async {
    final data = await GetIt.I<TrendingService>().getAllTrending(timeWindow);
    final results = data['results'] as List<dynamic>;
    return results.map((json) => parseTrendingItem(Map<String, dynamic>.from(json))).toList();
  }

  TrendingItem parseTrendingItem(Map<String, dynamic> json) {
    // Определяем тип объекта по `media_type`
    final mediaType = json['media_type'] as String;
    switch (mediaType) {
      case 'movie':
        return Movie.fromJson(json);
      case 'tv':
        return TvShow.fromJson(json);
      default:
        throw UnsupportedError('Unknown media type: $mediaType');
    }
  }
}
