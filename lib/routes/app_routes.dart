import 'package:flutter/material.dart';
import 'package:flutter_weather_app/views/city_view.dart';
import 'package:flutter_weather_app/views/home_view.dart';
import 'package:flutter_weather_app/views/splash_view.dart';

class AppRoutes {
  static Route genereteRoutes(RouteSettings settings) {
    Widget screen = getScreenNullable(settings) ?? const HomeScreen();

    return MaterialPageRoute(builder: (context) => screen, settings: settings);
  }

  static Widget? getScreenNullable(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.tag:
        return const HomeScreen();
      case CityView.tag:
        CityViewArgs args;
        args = settings.arguments as CityViewArgs;
        return CityView(cityName: args.cityName);
      case SplashView.tag:
        return const SplashView();
      default:
        return null;
    }
  }
}
