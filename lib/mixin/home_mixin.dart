import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/viewmodel/five_days_viewmodel.dart';
import 'package:flutter_weather_app/viewmodel/weather_viewmodel.dart';

mixin HomeMixin<T extends StatefulWidget> on State<T> {
  late WeatherViewmodel weatherViewmodel;
  late FiveDaysViewmodel fiveDaysViewmodel;

  late double heightQ = MediaQuery.of(context).size.height;
  late double widthQ = MediaQuery.of(context).size.width;

  DateTime time = DateTime.now();

  @override
  void initState() {
    super.initState();
    weatherViewmodel = BlocProvider.getBloc<WeatherViewmodel>();
    weatherViewmodel.getData();

    fiveDaysViewmodel = BlocProvider.getBloc<FiveDaysViewmodel>();
    fiveDaysViewmodel.getData();
  }
}
