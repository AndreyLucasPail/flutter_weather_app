import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_weather_app/models/search_model.dart';
import 'package:flutter_weather_app/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

class SearchViewmodel extends BlocBase {
  final ApiService _apiService = ApiService();

  final _byCityController = BehaviorSubject<SearchWeatherModel>();

  Stream<SearchWeatherModel> get byCityStream => _byCityController.stream;

  Future<void> getDataByCity(String city) async {
    try {
      final response = await _apiService.byCityRequest(city);

      final byCityModel = SearchWeatherModel.fromJson(response);
      _byCityController.sink.add(byCityModel);
    } catch (e) {
      _byCityController.addError("Erro ao carregar de cidades dados: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _byCityController.close();
  }
}
