part of 'trending_bloc.dart';

abstract class TrendingEvent {}

class LoadTrendings extends TrendingEvent {
  final String timeWindow;

  LoadTrendings({required this.timeWindow});
}
