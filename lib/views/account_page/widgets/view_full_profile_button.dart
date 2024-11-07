import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/blocs/url_launcher_bloc/url_launcher_bloc.dart';
import '../../../theme/app_box_decoration_style.dart';
import '../../../theme/app_button_style.dart';

class ViewFullProfileButton extends StatelessWidget {
  const ViewFullProfileButton({super.key, required this.username});
  final String username;
  @override
  Widget build(BuildContext context) {
    return BlocListener<UrlLauncherBloc, UrlLauncherState>(
      listener: (context, state) {
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          decoration: AppBoxDecorationStyle.boxDecoration,
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              _openUrl(context);
            },
            style: AppButtonStyle.linkAltButtonStyle,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('View full profile'),
                SizedBox(
                  width: 8,
                ),
                Icon(Icons.shortcut_sharp)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openUrl(BuildContext context) {
    context.read<UrlLauncherBloc>().add(LaunchUrlLauncherEvent('/u/$username'));
  }
}
