import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocationService {
  // Method to get the current location
  Future<Position> getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Request location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied. Cannot access location.');
    }

    // Get the current position
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}


Future<void> cacheLocation(double latitude, double longitude, double heading) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('latitude', latitude);
  await prefs.setDouble('longitude', longitude);
  await prefs.setDouble('heading', heading);

}

Future<Map<String, double?>?> getCachedLocation() async {
  final prefs = await SharedPreferences.getInstance();
  final lat = prefs.getDouble('latitude');
  final lon = prefs.getDouble('longitude');
  final heading = prefs.getDouble('heading');

  if (lat != null && lon != null) {
    return {'latitude': lat, 'longitude': lon, 'heading': heading};
  }
  return null; // no cached data
}


Future<Position> fetchCurrentLocation() async {
  var cached = await getCachedLocation();
  if (cached != null) {

    Position position = Position(
      latitude: cached['latitude']!,
      longitude: cached['longitude']!,
      heading: cached['heading']!,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      speed: 0,
      speedAccuracy: 0,
      isMocked: false,
      headingAccuracy: 0,
      altitudeAccuracy: 0
    );

    return position;
    
  } else {

    Position position = await LocationService().getCurrentLocation();
    cacheLocation(position.latitude, position.longitude, position.heading);
    return position;

  }
}
