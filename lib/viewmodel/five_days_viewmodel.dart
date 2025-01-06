import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_weather_app/models/five_days_model.dart';
import 'package:flutter_weather_app/service/api_service.dart';
import 'package:flutter_weather_app/service/location_service.dart';
import 'package:rxdart/rxdart.dart';

class FiveDaysViewmodel extends BlocBase {
  final ApiService apiService = ApiService();
  final LocationService locationService = LocationService();

  final fiveDaysController = BehaviorSubject<FiveDaysModel>();

  Stream<FiveDaysModel> get fiveDaysStream => fiveDaysController.stream;

  Future<void> getData() async {
    try {
      final position = await locationService.getCurrentLocation();

      final response = await apiService.fiveDaysRequest(
        position.latitude,
        position.longitude,
      );

      final fiveDaysModel = FiveDaysModel.fromJson(response);
      fiveDaysController.sink.add(fiveDaysModel);
    } catch (e) {
      fiveDaysController.addError("Erro ao carregar dados: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    fiveDaysController.close();
  }
}
