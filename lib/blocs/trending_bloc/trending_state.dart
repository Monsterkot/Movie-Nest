part of 'trending_bloc.dart';

abstract class TrendingState {}

class TrendingInitial extends TrendingState {}

class LoadTrendingSuccess extends TrendingState {
  final List<TrendingItem> trendings;

  LoadTrendingSuccess({required this.trendings});
}

class LoadTrendingFailure extends TrendingState {}

class TrendingLoading extends TrendingState {}
