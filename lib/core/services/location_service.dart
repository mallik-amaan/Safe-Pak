import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  /// Returns the current position of the device.
  Future<Placemark?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    print("Getting current location...");
    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled.
      return null;
    }

    // Check for location permissions.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied.
        return null;
      }
    }
    print("Permission granted: $permission");
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever.
      return null;
    }

    // Get the current position.
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    print("Current position: ${position.latitude}, ${position.longitude}");
    print("Placemark: ${placemarks.first}");
    return placemarks.isNotEmpty ? placemarks.first : null;
  }
}
