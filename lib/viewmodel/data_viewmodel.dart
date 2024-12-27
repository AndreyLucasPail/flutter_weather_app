import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_weather_app/models/data_model.dart';
import 'package:flutter_weather_app/repository/api_service.dart';
import 'package:rxdart/rxdart.dart';

class DataViewmodel extends BlocBase {
  final ApiService apiService = ApiService();
  List<DataModel> data = [];

  final dataController = BehaviorSubject<DataModel>();

  Stream<DataModel> get dataStream => dataController.stream;

  Future<void> getData(String lat, String long) async {
    try {
      final response = await apiService.request(lat, long);

      final dataModel = DataModel.fromJson(response);

      dataController.sink.add(dataModel);
    } catch (e) {
      dataController.addError("Erro ao carregar dados: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    dataController.close();
  }
}
