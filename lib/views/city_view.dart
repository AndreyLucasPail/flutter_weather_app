import 'package:auto_size_text/auto_size_text.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_app/mixin/city_mixin.dart';
import 'package:flutter_weather_app/models/search_model.dart';
import 'package:flutter_weather_app/utils/colors/custom_colors.dart';
import 'package:flutter_weather_app/viewmodel/search_viewmodel.dart';

class CityViewArgs {
  CityViewArgs({this.cityName});

  String? cityName;
}

class CityView extends StatefulWidget {
  const CityView({super.key, this.cityName});

  static const tag = "/cityView";
  final String? cityName;

  @override
  State<CityView> createState() => _CityViewState();
}

class _CityViewState extends State<CityView> with CityMixin {
  late SearchViewmodel searchViewmodel;

  @override
  void initState() {
    super.initState();

    searchViewmodel = BlocProvider.getBloc<SearchViewmodel>();
    searchViewmodel.getDataByCity(widget.cityName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.nigthBlue,
      body: body(),
    );
  }

  Widget body() {
    return StreamBuilder<SearchWeatherModel>(
      stream: searchViewmodel.byCityStream,
      builder: (context, snapshot) {
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final weather = snapshot.data;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 35.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customAppBar(weather!),
                  const SizedBox(height: 20),
                  infoCircle(weather),
                  const SizedBox(height: 50),
                  infoWrap(weather),
                  const SizedBox(height: 20),
                  bottomText(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget customAppBar(SearchWeatherModel searchModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.white,
            size: 40,
          ),
        ),
        Text(
          searchModel.name!,
          style: const TextStyle(
            color: CustomColors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: widthQ * 0.15),
      ],
    );
  }

  Widget infoCircle(SearchWeatherModel weather) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 250,
      width: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.nigthBlue,
        boxShadow: [
          BoxShadow(
            color: CustomColors.white.withOpacity(0.25),
            blurRadius: 15,
            spreadRadius: 4,
            offset: const Offset(-10.0, -10.0),
          ),
          BoxShadow(
            color: CustomColors.black.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 4,
            offset: const Offset(10.0, 10.0),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: SvgPicture.asset(
              currentClimate(weather.climate!),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weather.temperature!.toStringAsFixed(0),
                style: const TextStyle(
                  color: CustomColors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "°C",
                style: TextStyle(
                  color: CustomColors.white,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoWrap(SearchWeatherModel weather) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      children: [
        infoCard(Icons.air, "${weather.windSpeed}m/s", "vento"),
        infoCard(Icons.speed_outlined, "${weather.pressure} mb", "pressão"),
        infoCard(Icons.invert_colors_on, "${weather.humidity}%", "Humidade"),
        infoCard(Icons.visibility_outlined, "${weather.visibility! / 1000} Km",
            "Visibilidade"),
        infoCard(
            Icons.cloud_queue_outlined, "${weather.cloudsPercent!}%", "Nuvens"),
        infoCard(Icons.air, windDirection(weather.windDirec!),
            "${weather.windDirec!}°"),
      ],
    );
  }

  Widget infoCard(IconData icon, String text, String data) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: CustomColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60,
            color: CustomColors.white,
          ),
          Text(
            data,
            style: const TextStyle(
              color: CustomColors.white,
              fontSize: 16,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: CustomColors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomText() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: AutoSizeText(
        "© 2012 — 2025 OpenWeather ® All rights reserved",
        style: TextStyle(
          color: CustomColors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
