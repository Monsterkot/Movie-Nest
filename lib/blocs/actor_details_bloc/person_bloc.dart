import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/models/person/person_details.dart';
import 'package:movie_nest_app/repositories/person_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonDetailsInitial()) {
    on<LoadPersonDetails>((event, emit) async {
      try {
        emit(PersonDetailsLoading());
        final person = await GetIt.I<PersonRepository>().getPersonDetails(event.id);
        emit(PersonDetailsLoadSuccess(person: person));
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
        emit(PersonDetailsLoadFailure(message: 'Something went wrong, try again later'));
      }
    });
  }
}
