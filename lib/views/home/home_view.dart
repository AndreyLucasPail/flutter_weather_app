import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/current_weather_model.dart';
import 'package:flutter_weather_app/models/five_days_model.dart';
import 'package:flutter_weather_app/utils/colors/custom_colors.dart';
import 'package:flutter_weather_app/views/home/home_mixin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: StreamBuilder<CurrentWeatherModel>(
        stream: weatherViewmodel.currentStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final weather = snapshot.data;
            return Container(
              height: heightQ,
              width: widthQ,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    CustomColors.blue,
                    CustomColors.grey,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    todayCard(weather),
                    const SizedBox(height: 20),
                    infoGrid(weather),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget todayCard(CurrentWeatherModel? weather) {
    return Container(
      height: heightQ * 0.3,
      decoration: BoxDecoration(
        color: CustomColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Hoje",
                style: TextStyle(
                  color: CustomColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${time.day}/${time.month}",
                style: const TextStyle(
                  color: CustomColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${(weather!.temperature)!.toStringAsFixed(1)} ℃",
                style: const TextStyle(
                  color: CustomColors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.sunny,
                color: CustomColors.yellow,
                size: 100,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: CustomColors.yellow,
              ),
              Text(
                "${(weather.name)!.toUpperCase()}, ${weather.country}",
                style: const TextStyle(
                  color: CustomColors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget fiveDaysCard() {
    return StreamBuilder<FiveDaysModel>(
      stream: fiveDaysViewmodel.fiveDaysController,
      builder: (context, snapshot) {
        return Container();
      },
    );
  }

  Widget infoGrid(CurrentWeatherModel? weather) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: [
        infoCard("${weather!.cloudsPercent}"),
        infoCard("${weather.humidity}"),
        infoCard("${weather.pressure}"),
        infoCard("${weather.sunRise}"),
        infoCard("${weather.sunSet}"),
      ],
    );
  }

  Widget infoCard(String text) {
    return Container(
      height: 160,
      width: widthQ * 0.44,
      decoration: BoxDecoration(
        color: CustomColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
