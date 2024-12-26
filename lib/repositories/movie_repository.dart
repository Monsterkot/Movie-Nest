import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/constants/media_type.dart';
import 'package:movie_nest_app/models/movie_details/movie_details.dart';
import 'package:movie_nest_app/models/movie_response/movie_response.dart';
import 'package:movie_nest_app/services/movie_service.dart';

class MovieRepository {
  Future<MovieResponse> getPopularMovies(int page) async {
    final json = await GetIt.I<MovieService>().getPopularMovies(page);
    final popularMovies = MovieResponse.fromJson(json);
    return popularMovies;
  }

  Future<MovieResponse> getUpcomingMovies() async {
    final json = await GetIt.I<MovieService>().getUpcomingMovies();
    final upcomingMovies = MovieResponse.fromJson(json);
    return upcomingMovies;
  }

  Future<MovieResponse> getTopRatedMovies() async {
    final json = await GetIt.I<MovieService>().getTopRatedMovies();
    final topRatedMovies = MovieResponse.fromJson(json);
    return topRatedMovies;
  }

  Future<MovieResponse> getNowPlayingMovies() async {
    final json = await GetIt.I<MovieService>().getNowPlayingMovies();
    final nowPlayingMovies = MovieResponse.fromJson(json);
    return nowPlayingMovies;
  }

  Future<MovieDetails> getMovieDetails(int movieId) async {
    final json = await GetIt.I<MovieService>().getMovieDetails(movieId);
    final movieDetails = MovieDetails.fromJson(json);
    return movieDetails;
  }

  Future<MovieResponse> getMoviesByQuery(String query, int page) async {
    final json = await GetIt.I<MovieService>().getMoviesByQuery(query, page);
    final movieDetails = MovieResponse.fromJson(json);
    return movieDetails;
  }

  Future<bool> isFavorite(int movieId) async {
    final json = await GetIt.I<MovieService>().isFavorite(movieId);
    final isFavorite = json['favorite'] as bool;
    return isFavorite;
  }

  Future<void> toggleFavorite({required int movieId, required bool isLiked}) async {
    await GetIt.I<MovieService>()
        .markAsFavorite(mediaType: MediaType.movie, mediaId: movieId, isFavorite: isLiked);
  }
}
