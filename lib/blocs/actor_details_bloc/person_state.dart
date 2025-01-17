part of 'person_bloc.dart';

abstract class PersonState {}

class PersonDetailsInitial extends PersonState {}

class PersonDetailsLoading extends PersonState {}

class PersonDetailsLoadSuccess extends PersonState {
  final PersonDetails person;

  PersonDetailsLoadSuccess({required this.person});
}

class PersonDetailsLoadFailure extends PersonState {
}
