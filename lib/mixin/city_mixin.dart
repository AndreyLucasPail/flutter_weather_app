import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/viewmodel/weather_viewmodel.dart';

mixin CityMixin<T extends StatefulWidget> on State<T> {
  late WeatherViewmodel weatherViewmodel;

  late String city;

  @override
  void initState() {
    super.initState();
    final city = (widget as dynamic).cityName;
    weatherViewmodel = BlocProvider.getBloc<WeatherViewmodel>();
    weatherViewmodel.getDataByCity(city);
  }

  String currentClimate(String climate) {
    if (climate == "Clear") {
      return "assets/sun.svg";
    } else if (climate == "Rain") {
      return "assets/rain.svg";
    } else if (climate == "Clouds") {
      return "assets/clouds.svg";
    } else if (climate == "Drizzle") {
      return "assets/drizzle.svg";
    } else if (climate == "Thunderstorm") {
      return "assets/thunderstorm.svg";
    } else {
      return "assets/snow.svg";
    }
  }
}
