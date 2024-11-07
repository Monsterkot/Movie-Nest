part of 'url_launcher_bloc.dart';

abstract class UrlLauncherEvent {}

class LaunchUrlLauncherEvent extends UrlLauncherEvent {
  LaunchUrlLauncherEvent(this.url);

  final String url;
}
