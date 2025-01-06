import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_weather_app/models/current_weather_model.dart';
import 'package:flutter_weather_app/service/api_service.dart';
import 'package:flutter_weather_app/service/location_service.dart';
import 'package:rxdart/rxdart.dart';

class WeatherViewmodel extends BlocBase {
  final ApiService apiService = ApiService();
  final LocationService locationService = LocationService();

  final currentController = BehaviorSubject<CurrentWeatherModel>();

  Stream<CurrentWeatherModel> get currentStream => currentController.stream;

  Future<void> getData() async {
    try {
      final position = await locationService.getCurrentLocation();
      print("${position.latitude}>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<${position.longitude}");
      final response = await apiService.currentRequest(
        position.latitude,
        position.longitude,
      );

      final weatherModel = CurrentWeatherModel.fromJson(response);

      currentController.sink.add(weatherModel);
    } catch (e) {
      currentController.addError("Erro ao carregar dados: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    currentController.close();
  }
}
