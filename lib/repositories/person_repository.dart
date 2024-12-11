import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/services/person_service.dart';

import '../models/person/person_details.dart';

class PersonRepository {
  
  Future<PersonDetails> getPersonDetails(int id) async {
    final json = await GetIt.I<PersonService>().getPersonDetails(id);
    final person = PersonDetails.fromJson(json);
    return person;
  }

  

}
