import 'package:flutter/material.dart';
import '../../../theme/app_box_decoration_style.dart';
import '../../../theme/app_text_style.dart';

class ActorKnownForWidget extends StatelessWidget {
  const ActorKnownForWidget({super.key});

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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Known For',
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
                    itemCount: 20,
                    itemExtent: 150,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            DecoratedBox(
                              decoration: AppBoxDecorationStyle.boxDecoration,
                              child: const ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                clipBehavior: Clip.hardEdge,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                        image:
                                            AssetImage('lib/images/flow.png')),
                                    SizedBox(height: 5),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Flow',
                                            style: AppTextStyle
                                                .small18WhiteTextStyle,
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
                                  // AutoRouter.of(context)
                                  //     .push(MovieDetailsRoute(movieId: 0));
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
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
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
