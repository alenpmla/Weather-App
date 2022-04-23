import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<Position> getLocation();
}

class LocationServiceImpl implements LocationService {
  @override
  Future<Position> getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.lowest);
    return position;
  }
}
