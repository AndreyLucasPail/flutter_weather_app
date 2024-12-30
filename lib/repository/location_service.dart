import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    final bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception("Serviço de localização está desativado");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão de localização foi negada.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Permissão de localização foi negada permanentemente.");
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
