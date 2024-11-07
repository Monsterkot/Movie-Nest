import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/blocs/url_launcher_bloc/url_launcher_bloc.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const linkTextStyle = TextStyle(
      color: Colors.lightBlue,
      decoration: TextDecoration.underline,
      fontSize: 16,
    );
    bool isSnackBarVisible = false;
    return BlocListener<UrlLauncherBloc, UrlLauncherState>(
      listener: (context, state) {
        if (state is UrlLauncherLaunchFailure) {
          if (isSnackBarVisible) return;
          isSnackBarVisible = true;
          final snackBar = SnackBar(
            backgroundColor: Colors.grey.withOpacity(0.4),
            content: Text(state.message),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.fixed,
            elevation: 10,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then(
            (_) {
              isSnackBarVisible = false;
            },
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              'Log in to your account',
              style: theme.textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'To use the editing and rating features of TMDB, as well as to receive personal recommendations, you must log in to your account. If you don\'t have an account, registering it is free and easy. ',
                      style: theme.textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: 'Click here to register.',
                      style: linkTextStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context
                              .read<UrlLauncherBloc>()
                              .add(LaunchUrlLauncherEvent('/signup'));
                        },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'If you have registered but have not received a confirmation email. ',
                      style: theme.textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: 'Click here to confirm email.',
                      style: linkTextStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.read<UrlLauncherBloc>().add(
                              LaunchUrlLauncherEvent(
                                  '/resend-email-verification'));
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
