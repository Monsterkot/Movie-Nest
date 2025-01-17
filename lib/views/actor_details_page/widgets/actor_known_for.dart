import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_nest_app/constants/app_constants.dart';
import 'package:movie_nest_app/models/trending_content/trending_item.dart';
import '../../../generated/l10n.dart';
import '../../../models/movie/movie.dart';
import '../../../models/tv_show/tv_show.dart';
import '../../../router/router.gr.dart';
import '../../../theme/app_box_decoration_style.dart';
import '../../../theme/app_text_style.dart';

class ActorKnownForWidget extends StatelessWidget {
  const ActorKnownForWidget({super.key, required this.combinedCredits});
  final List<TrendingItem> combinedCredits;
  @override
  Widget build(BuildContext context) {
    final boxDecoration = AppBoxDecorationStyle.boxDecoration;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: boxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                S.of(context).knownFor,
                style: AppTextStyle.middleWhiteTextStyle,
              ),
            ),
            SizedBox(
              height: 260,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Scrollbar(
                  radius: const Radius.circular(10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,//TODO 
                    itemExtent: 150,
                    itemBuilder: (BuildContext context, int index) {
                      final item = combinedCredits[index];
                      return _knownForItem(item, context);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _knownForItem(TrendingItem item, BuildContext context) {
    String title;
    String? posterPath;
    int? id;

    String mediaType = item.mediaType!;

    if (mediaType == 'movie') {
      // Кастуем item к типу Movie и извлекаем данные
      final movie = item as Movie;
      title = movie.title;
      posterPath = movie.posterPath;
      id = movie.id;
    } else if (mediaType == 'tv') {
      // Кастуем item к типу TVShow и извлекаем данные
      final tvShow = item as TvShow;
      title = tvShow.name;
      posterPath = tvShow.posterPath;
      id = tvShow.id;
    } else {
      // Если тип неизвестен
      title = 'Unknown Media';
      posterPath = null;
    }

    void openDetailsRoute(int id) {
      switch (mediaType) {
        case 'movie':
          AutoRouter.of(context).push(MovieDetailsRoute(movieId: id));
          break;
        case 'tv':
          AutoRouter.of(context).push(TvShowDetailsRoute(tvShowId: id));
          break;
        default:
          AutoRouter.of(context).push(const ErrorRoute());
          break;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          DecoratedBox(
            decoration: AppBoxDecorationStyle.boxDecoration,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  posterPath != null
                      ? FadeInImage(
                          placeholder: const AssetImage('lib/images/placeholder.png'),
                          image: NetworkImage('$imageUrl$posterPath'),
                        )
                      : const Image(
                          image: AssetImage('lib/images/no_poster_avalible.png'),
                        ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: AppTextStyle.small16WhiteTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                openDetailsRoute(id!);
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
