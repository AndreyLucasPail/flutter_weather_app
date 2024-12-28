import 'package:dio/dio.dart';

class ApiService {
  static final _instance = ApiService.internal();

  factory ApiService() => _instance;

  ApiService.internal();

  final String apiKey = "997a824a72c60d7161e5b58d5f5dc618";

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> request(String lat, String long) async {
    try {
      final String url = "https://api.openweathermap.org/data/3.0/"
          "onecall?lat={$lat}&lon={$long}&appid={$apiKey}";

      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
      return {};
    }
  }
}
