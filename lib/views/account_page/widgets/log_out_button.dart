import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/theme/app_button_style.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';

import '../../../router/router.gr.dart';
import '../../../services/session_service.dart';
import '../../../theme/app_box_decoration_style.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: AppBoxDecorationStyle.boxDecoration,
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            _showModalDialog(context);
          },
          style: AppButtonStyle.logOutButtonStyle,
          child: const Text('Log Out'),
        ),
      ),
    );
  }

  void _showModalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withValues(alpha: 0.5),
          content: const Text('Are you sure you want to log out?'),
          contentTextStyle: AppTextStyle.small16WhiteTextStyle,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          actions: [
            TextButton(
              onPressed: () {
                _logoutUser(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceAround,
        );
      },
    );
  }

  Future<void> _logoutUser(BuildContext context) async {
    await GetIt.I<SessionService>().clearSessionId();

    // Используем addPostFrameCallback для навигации после завершения асинхронной работы
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AutoRouter.of(context).replaceAll([const AuthRoute()]);
    });
  }
}
