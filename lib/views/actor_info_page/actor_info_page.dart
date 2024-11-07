import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_nest_app/views/actor_info_page/widgets/actor_known_for.dart';
import 'package:movie_nest_app/views/actor_info_page/widgets/actor_main_info.dart';
import 'package:movie_nest_app/views/widgets/custom_background.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';
import 'widgets/actor_biography.dart';

@RoutePage()
class ActorInfoScreen extends StatelessWidget {
  const ActorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: const Text(
          'Brad Pitt',
          style: AppTextStyle.middleWhiteTextStyle,
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: CustomPaint(
        size: Size.infinite,
        painter: BackgroundPainter(),
        child: ListView(
          children: const [
            ActorMainInfoWidget(),
            ActorBiographyWidget(),
            ActorKnownForWidget(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
