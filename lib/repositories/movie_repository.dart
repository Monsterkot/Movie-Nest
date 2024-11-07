import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/models/movie_details/movie_details.dart';
import 'package:movie_nest_app/models/popular_movie_response/popular_movie_response.dart';
import 'package:movie_nest_app/services/movie_service.dart';

class MovieRepository {
  void searchMovies(String query) {
    // return _movies
    //     .where(
    //         (movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
    //     .toList();
  }

  Future<PopularMovieResponse> getPopularMovies(int page) async {
    final json = await GetIt.I<MovieService>().getPopularMovies(page);
    final popularMovies = PopularMovieResponse.fromJson(json);
    return popularMovies;
  }

  Future<MovieDetails> getMovieDetails(int movieId) async {
    final json = await GetIt.I<MovieService>().getMovieDetails(movieId);
    final movieDetails = MovieDetails.fromJson(json);
    return movieDetails;
  }

  Future<PopularMovieResponse> getMoviesByQuery(String query, int page) async {
    final json = await GetIt.I<MovieService>().getMoviesByQuery(query, page);
    final movieDetails = PopularMovieResponse.fromJson(json);
    return movieDetails;
  }
}
