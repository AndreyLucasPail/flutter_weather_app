import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_weather_app/models/current_weather_model.dart';
import 'package:flutter_weather_app/service/api_service.dart';
import 'package:flutter_weather_app/service/location_service.dart';
import 'package:rxdart/rxdart.dart';

class WeatherViewmodel extends BlocBase {
  final ApiService apiService = ApiService();
  final LocationService locationService = LocationService();

  final _currentController = BehaviorSubject<CurrentWeatherModel>();
  final _byCityController = BehaviorSubject<CurrentWeatherModel>();
  final _isExpandedController = BehaviorSubject<bool>.seeded(false);

  Stream<CurrentWeatherModel> get currentStream => _currentController.stream;
  Stream<CurrentWeatherModel> get byCityStream => _byCityController.stream;
  Stream<bool> get isExpandedStream => _isExpandedController.stream;

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

      _currentController.sink.add(weatherModel);
    } catch (e) {
      _currentController.addError("Erro ao carregar dados: $e");
    }
  }

  Future<void> getDataByCity(String city) async {
    try {
      final response = await apiService.byCityRequest(city);

      final byCityModel = CurrentWeatherModel.fromJson(response);
      _byCityController.sink.add(byCityModel);
    } catch (e) {
      _byCityController.addError("Erro ao carregar de cidades dados: $e");
    }
  }

  void toggledExpansion() {
    bool current = _isExpandedController.value;
    _isExpandedController.sink.add(!current);
  }

  @override
  void dispose() {
    super.dispose();
    _currentController.close();
    _byCityController.close();
    _isExpandedController.close();
  }
}
