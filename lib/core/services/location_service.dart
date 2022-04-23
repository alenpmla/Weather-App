import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/error/exceptions.dart';

abstract class LocationService {
  Future<Position> getLocation();
}

class LocationServiceImpl implements LocationService {
  @override
  Future<Position> getLocation() async {
    LocationPermission permission;
    Position position;
    try {
      permission = await Geolocator.requestPermission();
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest);
    } catch (e) {
      throw LocationException();
    }
    return position;
  }
}
