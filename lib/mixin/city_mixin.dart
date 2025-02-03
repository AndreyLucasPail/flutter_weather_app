import 'package:flutter/material.dart';

mixin CityMixin<T extends StatefulWidget> on State<T> {
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
