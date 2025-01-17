import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_nest_app/theme/app_colors.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';

import '../../generated/l10n.dart';

@RoutePage()
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).error,
          style: AppTextStyle.middleWhiteTextStyle,
        ),
        leading: IconButton(
          onPressed: () => AutoRouter.of(context).popForced(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: AppColors.mainColor,
        child: Center(
          child: Text(
            S.of(context).routeError,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
