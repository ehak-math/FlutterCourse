import '../model/ride/ride.dart';
import '../model/ride/rides_filter.dart';
import '../model/ride_pref/ride_pref.dart';

abstract class RidesRepository {
  List<Ride> getRides(RidePreference preference, RidesFilter? filter);
}