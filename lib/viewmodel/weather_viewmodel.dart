import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_weather_app/models/current_weather_model.dart';
import 'package:flutter_weather_app/service/api_service.dart';
import 'package:flutter_weather_app/service/location_service.dart';
import 'package:rxdart/rxdart.dart';

class WeatherViewmodel extends BlocBase {
  final ApiService apiService = ApiService();
  final LocationService locationService = LocationService();

  final currentController = BehaviorSubject<CurrentWeatherModel>();
  final byCityController = BehaviorSubject<CurrentWeatherModel>();

  Stream<CurrentWeatherModel> get currentStream => currentController.stream;
  Stream<CurrentWeatherModel> get byCity => byCityController.stream;

  Future<void> getData() async {
    try {
      final position = await locationService.getCurrentLocation();
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${position.latitude}");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${position.longitude}");
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

  Future<void> getDataByCity(String city) async {
    try {
      final response = await apiService.byCityRequest(city);

      final byCityModel = CurrentWeatherModel.fromJson(response);
      byCityController.sink.add(byCityModel);
    } catch (e) {
      byCityController.addError("Erro ao carregar de cidades dados: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    currentController.close();
    byCityController.close();
  }
}
