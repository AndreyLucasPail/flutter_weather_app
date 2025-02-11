import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_weather_app/models/search_five_days_model.dart';
import 'package:flutter_weather_app/models/search_model.dart';
import 'package:flutter_weather_app/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

class SearchViewmodel extends BlocBase {
  final ApiService _apiService = ApiService();

  final _byCityController = BehaviorSubject<SearchWeatherModel>();
  final _fiveDaysController = BehaviorSubject<SearchFiveDaysModel>();

  Stream<SearchWeatherModel> get byCityStream => _byCityController.stream;
  Stream<SearchFiveDaysModel> get fiveDaysStream => _fiveDaysController.stream;

  Future<void> getDataByCity(String city) async {
    try {
      final response = await _apiService.byCityRequest(city);

      final byCityModel = SearchWeatherModel.fromJson(response);

      _byCityController.sink.add(byCityModel);
    } catch (e) {
      _byCityController.addError("Erro ao carregar dados de cidades: $e");
    }
  }

  Future<void> getCityFiveDays(String city) async {
    try {
      final response = await _apiService.cityFiveDaysRequest(city);

      final fiveDaysModel = SearchFiveDaysModel.fromJson(response);

      _fiveDaysController.sink.add(fiveDaysModel);
    } catch (e) {
      _fiveDaysController.addError("Erro ao carregar dados de cidades: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _byCityController.close();
    _fiveDaysController.close();
  }
}
