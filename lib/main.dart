import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/routes/app_routes.dart';
import 'package:flutter_weather_app/viewmodel/five_days_viewmodel.dart';
import 'package:flutter_weather_app/viewmodel/weather_viewmodel.dart';
import 'package:flutter_weather_app/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => WeatherViewmodel()),
        Bloc((i) => FiveDaysViewmodel()),
      ],
      dependencies: const [],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.tag,
        onGenerateRoute: AppRoutes.genereteRoutes,
      ),
    );
  }
}
