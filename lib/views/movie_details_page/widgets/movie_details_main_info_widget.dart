import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_nest_app/constants/app_constants.dart';
import 'package:movie_nest_app/models/genre/genre.dart';
import 'package:movie_nest_app/router/router.gr.dart';
import 'package:movie_nest_app/theme/app_box_decoration_style.dart';
import 'package:movie_nest_app/theme/app_button_style.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/views/widgets/radial_percent_widget.dart';
import '../../../models/movie_details/movie_details.dart';
import '../../../models/video/video.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key, required this.movieDetails});
  final MovieDetails movieDetails;

  @override
  Widget build(BuildContext context) {
    final boxDecoration = AppBoxDecorationStyle.boxDecoration;
    final videos = movieDetails.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube')
        .toList();
    return Column(
      children: [
        _TopPosterWidget(movieDetails.posterPath, movieDetails.backdropPath),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            decoration: boxDecoration,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: _MovieNameWidget(movieDetails.title, movieDetails.releaseDate),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ScoreWidget(movieDetails.voteAverage, videos),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: _SummeryWidget(
                    movieDetails.genres,
                    movieDetails.runtime,
                    movieDetails.releaseDate,
                    movieDetails.originCountry,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: _OverviewWidget(movieDetails.overview),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget(this.posterPath, this.backdropPath);
  final String? posterPath;
  final String? backdropPath;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backdropPath != null
            ? Image(image: NetworkImage('$imageUrl$backdropPath'))
            : const SizedBox.shrink(),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: NetworkImage('$imageUrl$posterPath'),
            ),
          ),
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget(this.title, this.releaseDate);

  final String title;
  final DateTime? releaseDate;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 3,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: ' (${releaseDate!.year.toString()})',
            style: TextStyle(
              color: Colors.blueGrey.shade300,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget(this.voteAverage, this.videos);
  final double voteAverage;
  final List<Video>? videos;
  @override
  Widget build(BuildContext context) {
    final ratingToHundreds = (voteAverage * 10).truncateToDouble();
    final trailerKey = videos?.isNotEmpty == true ? videos!.first.key : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: RadialPercentWidget(
                  percent: ratingToHundreds,
                  child: Text('${ratingToHundreds.toInt()}'),
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'User Score',
                style: AppTextStyle.small18WhiteTextStyle,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey,
          width: 1,
          height: 15,
        ),
        TextButton(
          onPressed: trailerKey != null
              ? () {
                  AutoRouter.of(context).push(YouTubePlayerRoute(youtubeKey: trailerKey));
                }
              : null,
          style: trailerKey != null
              ? AppButtonStyle.trailerButtonStyle
              : AppButtonStyle.disabledTrailerButtonStyle,
          child: const Row(
            children: [
              Icon(Icons.play_arrow),
              Text('Play Trailer'),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget(this.genres, this.runtime, this.releaseDate, this.originCountry);
  final List<Genre> genres;
  final int runtime;
  final DateTime? releaseDate;
  final List<String> originCountry;

  @override
  Widget build(BuildContext context) {
    final stringDate = '${releaseDate!.day}/${releaseDate!.month}/${releaseDate!.year}';
    final stringRuntime = formatRuntime(runtime);
    String formattedGenres = formatGenres(genres);
    return Text(
      '$stringDate (${originCountry.first}) $stringRuntime\n $formattedGenres',
      maxLines: 3,
      textAlign: TextAlign.center,
      style: AppTextStyle.small16WhiteTextStyle,
    );
  }

  String formatRuntime(int runtime) {
    int hours = runtime ~/ 60;
    int remainingMinutes = runtime % 60;
    return '${hours}h ${remainingMinutes}m';
  }

  String formatGenres(List<Genre> genres) {
    return genres.map((genre) => genre.name).join(', ');
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget(this.overview);
  final String overview;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: AppTextStyle.middleWhiteTextStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          overview,
          style: AppTextStyle.small16WhiteTextStyle,
        ),
      ],
    );
  }
}
