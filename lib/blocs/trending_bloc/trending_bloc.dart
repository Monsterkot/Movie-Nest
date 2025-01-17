import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/models/trending_content/trending_item.dart';
import 'package:movie_nest_app/repositories/trending_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  TrendingBloc() : super(TrendingInitial()) {
    on<LoadTrendings>((event, emit) async {
      emit(TrendingLoading());
      try {
        final trendings = await GetIt.I<TrendingRepository>().getAllTrending(event.timeWindow);
        emit(LoadTrendingSuccess(trendings: trendings));
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
        emit(LoadTrendingFailure());
      }
    });
  }
}
