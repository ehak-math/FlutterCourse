import 'package:week_3_blabla_project/model/ride/locations.dart';

import '../dummy_data/dummy_data.dart';
import '../repository/locations_repository.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {

  static const List<Location> availableLocations = fakeLocations;
  static  LocationsService? _instance;

  final LocationsRepository repository;

  LocationsService._internal(this.repository){}

  List<Location> getLocations() {
    return repository.getLocations();
  }

  static void initialize(LocationsRepository repository) {
     if (_instance == null) {
      _instance = LocationsService._internal(repository);
    }
  }

  static LocationsService get instance {
    if (_instance == null) {
      throw Exception("You should initialize your service first. Please call the initialize");
    }
    return _instance!;
  }
 
}
