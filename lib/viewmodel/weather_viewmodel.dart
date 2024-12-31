import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/repository/api_service.dart';
import 'package:flutter_weather_app/repository/location_service.dart';
import 'package:rxdart/rxdart.dart';

class WeatherViewmodel extends BlocBase {
  final ApiService apiService = ApiService();
  final LocationService locationService = LocationService();

  final weatherController = BehaviorSubject<WeatherModel>();

  Stream<WeatherModel> get weatherStream => weatherController.stream;

  Future<void> getData() async {
    try {
      final position = await locationService.getCurrentLocation();
      final response = await apiService.request(
        position.latitude,
        position.longitude,
      );

      final dataModel = WeatherModel.fromJson(response);

      weatherController.sink.add(dataModel);
    } catch (e) {
      weatherController.addError("Erro ao carregar dados: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    weatherController.close();
  }
}
