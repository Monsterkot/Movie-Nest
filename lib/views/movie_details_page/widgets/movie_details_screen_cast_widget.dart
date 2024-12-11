import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_nest_app/constants/app_constants.dart';
import 'package:movie_nest_app/models/movie_details/movie_details_credits/movie_details_credits.dart';
import 'package:movie_nest_app/router/router.gr.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import '../../../theme/app_box_decoration_style.dart';

class MovieDetailsMainScreenCastWidget extends StatelessWidget {
  const MovieDetailsMainScreenCastWidget({super.key, required this.movieDetailsCredits});
  final MovieDetailsCredits movieDetailsCredits;

  @override
  Widget build(BuildContext context) {
    final boxDecoration = AppBoxDecorationStyle.boxDecoration;
    final actors = movieDetailsCredits.cast;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: boxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Series Cast',
                style: AppTextStyle.middleWhiteTextStyle,
              ),
            ),
            SizedBox(
              height: 280,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Scrollbar(
                  radius: const Radius.circular(10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: actors.length,//TODO
                    itemExtent: 140,
                    itemBuilder: (BuildContext context, int index) {
                      final actor = actors[index];
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
                                    actor.profilePath == null
                                        ? const Image(
                                            image: AssetImage('lib/images/no_image_avalible.png'),
                                          )
                                        : FadeInImage(
                                            placeholder:
                                                const AssetImage('lib/images/placeholder.png'),
                                            image: NetworkImage('$imageUrl${actor.profilePath}'),
                                          ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            actor.name,
                                            style: AppTextStyle.small16WhiteTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            actor.character,
                                            style: AppTextStyle.small14White70TextStyle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
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
                                  AutoRouter.of(context).push(ActorDetailsRoute(id: actor.id));
                                },
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Full Cast & Crew',
                  style: AppTextStyle.small18WhiteTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
