import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/constants/app_constants.dart';
import 'package:movie_nest_app/utils/url_launcher.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'url_launcher_event.dart';
part 'url_launcher_state.dart';

class UrlLauncherBloc extends Bloc<UrlLauncherEvent, UrlLauncherState> {
  UrlLauncherBloc() : super(UrlLauncherInitial()) {
    on<LaunchUrlLauncherEvent>((event, emit) async {
      try {
        await UrlLauncher.launchURL('$tmdbHost${event.url}');
        emit(UrlLauncherSuccess());
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
        emit(UrlLauncherLaunchFailure());
      }
    });
  }
}
