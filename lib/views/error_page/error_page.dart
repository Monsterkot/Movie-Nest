import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_nest_app/theme/app_colors.dart';
import '../widgets/custom_app_bar.dart';

@RoutePage()
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Error',
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
        child: const Center(
          child: Text(
            'Route error',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
