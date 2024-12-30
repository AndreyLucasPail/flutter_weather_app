import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_weather_app/models/location_model.dart';
import 'package:flutter_weather_app/repository/location_service.dart';
import 'package:rxdart/rxdart.dart';

class LocationViewmodel extends BlocBase {
  LocationViewmodel();

  final LocationService? locationService = LocationService();

  final _locationController = BehaviorSubject<LocationModel>();

  Stream<LocationModel> get locationStream => _locationController.stream;

  Future<void> getLocation() async {
    try {
      final position = await locationService!.getCurrentLocation();
      _locationController.sink.add(
        LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } catch (e) {
      _locationController.addError('Erro ao obter localização: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _locationController.close();
  }
}
