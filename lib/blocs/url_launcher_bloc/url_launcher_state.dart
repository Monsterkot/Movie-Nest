part of 'url_launcher_bloc.dart';

abstract class UrlLauncherState {}

class UrlLauncherInitial extends UrlLauncherState {}

class UrlLauncherSuccess extends UrlLauncherState {}

class UrlLauncherLaunchFailure extends UrlLauncherState {
}
