import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/current_weather_model.dart';
import 'package:flutter_weather_app/models/five_days_model.dart';
import 'package:flutter_weather_app/utils/colors/custom_colors.dart';
import 'package:flutter_weather_app/mixin/home_mixin.dart';

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
                    today(weather),
                    const SizedBox(height: 30),
                    todayInfosCard(weather),
                    const SizedBox(height: 20),
                    fiveDaysCards(),
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

  Widget today(CurrentWeatherModel? weather) {
    return Column(
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
            Column(
              children: [
                Text(
                  "${(weather!.temperature)!.toStringAsFixed(1)} ℃",
                  style: const TextStyle(
                    color: CustomColors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "△ ${weather.tempMax}",
                      style: const TextStyle(
                        color: CustomColors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "▽ ${weather.tempMin}",
                      style: const TextStyle(
                        color: CustomColors.white,
                      ),
                    ),
                  ],
                ),
              ],
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
    );
  }

  Widget todayInfosCard(CurrentWeatherModel? weather) {
    return Container(
      height: heightQ * 0.3,
      decoration: BoxDecoration(
        color: CustomColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: [
          gridCard(Icons.air, "vento", "${weather!.windSpeed!} m/s"),
          gridCard(Icons.speed_outlined, "pressão", "${weather.pressure!}"),
          gridCard(Icons.invert_colors_on, "Humidade", "${weather.humidity!}%"),
          gridCard(
            Icons.visibility_outlined,
            "Visibilidade",
            "${weather.visibility! / 1000} Km",
          ),
          gridCard(
            Icons.cloud_outlined,
            "Nuvens",
            "${weather.cloudsPercent!}%",
          ),
          gridCard(
            Icons.air,
            windDirection(weather.windDirec!),
            "${weather.windDirec!}°",
          ),
        ],
      ),
    );
  }

  Widget gridCard(
    IconData icon,
    String type,
    String data,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: CustomColors.white,
        ),
        Text(
          data,
          style: const TextStyle(
            color: CustomColors.white,
            fontSize: 14,
          ),
        ),
        Text(
          type,
          style: const TextStyle(
            color: CustomColors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget fiveDaysCards() {
    return StreamBuilder<FiveDaysModel>(
      stream: fiveDaysViewmodel.fiveDaysController,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Erro ao carregar previsão: ${snapshot.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          final fiveDays = snapshot.data;
          final todayForecast = fiveDays!.getPerHourForecast();

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                height: heightQ * 0.35,
                width: widthQ,
                decoration: BoxDecoration(
                  color: CustomColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Previsão de 3 em 3 horas",
                      style: TextStyle(
                        color: CustomColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    threeHourInfo(fiveDays),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8.0),
                height: heightQ * 0.35,
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
                    fiveDaysInfo(todayForecast),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget threeHourInfo(FiveDaysModel? dayForecast) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: dayForecast!.list!.map((day) {
          List<String> parts = day.dtTxt!.split(" ");
          final date = parts[0];
          final time = parts[1];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.5),
            child: Container(
              height: heightQ * 0.29,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: CustomColors.green,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "hoje",
                    style: TextStyle(
                      color: CustomColors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    date.substring(5),
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    time.substring(0, 5),
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${(day.temperature)!.toStringAsFixed(0)}°",
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${day.speed} Km/h",
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget fiveDaysInfo(List<DayForecast>? dayForecast) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: dayForecast!.map((days) {
          List<String> parts = days.dtTxt!.split(" ");
          final date = parts[0];
          // final time = parts[1];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.5),
            child: Container(
              height: heightQ * 0.29,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: CustomColors.green,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    date.substring(5),
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${(days.tempMax)!.toStringAsFixed(1)}°",
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${(days.tempMin)!.toStringAsFixed(1)}°",
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${days.speed} Km/h",
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
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
