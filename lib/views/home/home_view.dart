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
    return StreamBuilder<CurrentWeatherModel>(
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    todayCard(weather),
                    const SizedBox(height: 20),
                    fiveDaysCard(),
                    const SizedBox(height: 20),
                    infoGrid(weather),
                  ],
                ),
              ),
            ),
          );
        }
      },
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
        if (snapshot.hasError) {
          print("ERRO>>${snapshot.error}");
          return Center(
            child: Text(
              "Erro ao carregar previsão: ${snapshot.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          final fiveDays = snapshot.data;

          return Container(
            height: heightQ * 0.3,
            width: widthQ,
            decoration: BoxDecoration(
              color: CustomColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                const Text(
                  "Previsão para os proximos 5 dias",
                  style: TextStyle(
                    color: CustomColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                fiveDaysInfo(fiveDays!),
              ],
            ),
          );
        }
      },
    );
  }

  Widget fiveDaysInfo(FiveDaysModel fiveDays) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: fiveDays.list!.map((days) {
          return Container(
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                Text(days.dtTxt ?? "N/A"),
              ],
            ),
          );
        }).toList(),
      ),
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
