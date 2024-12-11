import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_nest_app/constants/app_constants.dart';
import 'package:movie_nest_app/models/genre/genre.dart';
import 'package:movie_nest_app/models/tv_show_details/tv_show_details.dart';
import 'package:movie_nest_app/models/video/video.dart';
import 'package:movie_nest_app/router/router.gr.dart';
import 'package:movie_nest_app/theme/app_box_decoration_style.dart';
import 'package:movie_nest_app/theme/app_button_style.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/views/widgets/radial_percent_widget.dart';

class TvShowDetailsMainInfoWidget extends StatelessWidget {
  const TvShowDetailsMainInfoWidget({super.key, required this.tvShowDetails});
  final TvShowDetails tvShowDetails;

  @override
  Widget build(BuildContext context) {
    final boxDecoration = AppBoxDecorationStyle.boxDecoration;
    final videos = tvShowDetails.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube')
        .toList();
    return Column(
      children: [
        _TopPosterWidget(tvShowDetails.posterPath, tvShowDetails.backdropPath),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            decoration: boxDecoration,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: _MovieNameWidget(
                    tvShowDetails.name,
                    tvShowDetails.firstAirDate,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ScoreWidget(tvShowDetails.voteAverage, videos),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: _SummeryWidget(
                    tvShowDetails.genres,
                    tvShowDetails.firstAirDate,
                    tvShowDetails.originCountry,
                  ),
                ),
                tvShowDetails.overview != null && tvShowDetails.overview != ''
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: _OverviewWidget(tvShowDetails.overview!),
                      )
                    : const SizedBox(height: 20),
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
        if (backdropPath != null) Image(image: NetworkImage('$imageUrl$backdropPath')),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: posterPath != null
                ? Image(
                    image: NetworkImage('$imageUrl$posterPath'),
                  )
                : Container(
                    height: 210,
                    width: 120,
                    color: Colors.black.withOpacity(0.6),
                    child: Icon(
                      Icons.local_movies,
                      color: Colors.white.withOpacity(0.6),
                      size: 50,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget(this.name, this.firstAirDate);

  final String name;
  final DateTime? firstAirDate;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 3,
      text: TextSpan(
        children: [
          TextSpan(
            text: name,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (firstAirDate != null)
            TextSpan(
              text: ' (${firstAirDate!.year.toString()})',
              style: TextStyle(
                color: Colors.blueGrey.shade300,
                fontSize: 18,
              ),
            ),
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
  const _SummeryWidget(this.genres, this.firstAirDate, this.originCountry);
  final List<Genre> genres;
  final DateTime? firstAirDate;
  final List<String> originCountry;

  @override
  Widget build(BuildContext context) {
    String stringDate = '';
    String formattedGenres = '';
    if (firstAirDate != null) {
      stringDate = DateFormat.yMMMMd().format(firstAirDate!).toString();
    }
    if (genres.isNotEmpty) {
      formattedGenres = '\n${formatGenres(genres)}';
    }

    return Text(
      '$stringDate (${originCountry.first})$formattedGenres',
      maxLines: 3,
      textAlign: TextAlign.center,
      style: AppTextStyle.small16WhiteTextStyle,
    );
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
