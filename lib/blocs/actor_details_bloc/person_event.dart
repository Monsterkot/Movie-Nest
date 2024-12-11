part of 'person_bloc.dart';

abstract class PersonEvent {}

class LoadPersonDetails extends PersonEvent {
  final int id;

  LoadPersonDetails({required this.id});
}
