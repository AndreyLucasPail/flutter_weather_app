// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class ApiService {
  static final _instance = ApiService.internal();

  factory ApiService() => _instance;

  ApiService.internal();

  final String apiKey = "4b41911090eb08416fe72aa09174cb80";

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> currentRequest(double lat, double long) async {
    try {
      final String url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric&lang=pt_br";

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

  Future<Map<String, dynamic>> fiveDaysRequest(double lat, double long) async {
    try {
      final String url =
          "api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey";

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
