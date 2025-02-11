import 'package:flutter/material.dart';
import 'package:flutter_weather_app/viewmodel/search_viewmodel.dart';

mixin CityMixin<T extends StatefulWidget> on State<T> {
  late double widthQ = MediaQuery.of(context).size.width;
  late double heightQ = MediaQuery.of(context).size.height;

  late SearchViewmodel searchViewmodel;

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

  String windDirection(num direction) {
    if (direction == 0 || direction == 360) {
      return "NORTE";
    } else if (0 > direction && direction < 90) {
      return "NORDESTE";
    } else if (direction == 90) {
      return "LESTE";
    } else if (direction < 180 && direction > 90) {
      return "SUDESTE";
    } else if (direction == 180) {
      return "SUL";
    } else if (direction > 180 && direction < 270) {
      return "SUDOESTE";
    } else if (direction == 270) {
      return "OESTE";
    } else {
      return "NOROESTE";
    }
  }
}
