import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_app/models/current_weather_model.dart';
import 'package:flutter_weather_app/models/five_days_model.dart';
import 'package:flutter_weather_app/utils/colors/custom_colors.dart';
import 'package:flutter_weather_app/mixin/home_mixin.dart';
import 'package:flutter_weather_app/widgets/animations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
                    const SizedBox(height: 60),
                    todayInfosCard(weather),
                    const SizedBox(height: 20),
                    fiveDaysCards(),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              weather!.name!,
              style: const TextStyle(
                color: CustomColors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              "${time.day}/${time.month}/${time.year}",
              style: const TextStyle(
                color: CustomColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width * 0.6,
          color: CustomColors.white,
        ),
        Text(
          weather.description!,
          style: const TextStyle(
            color: CustomColors.grey400,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: SvgPicture.asset("assets/sun.svg"),
            ),
            Column(
              children: [
                Text(
                  "${(weather.temperature)!.toStringAsFixed(1)} ℃",
                  style: const TextStyle(
                    color: CustomColors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sensação de ${(weather.feelsLike)!.toStringAsFixed(1)} ℃",
                  style: const TextStyle(
                    color: CustomColors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "△ ${weather.tempMax}",
                      style: const TextStyle(
                        color: CustomColors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "▽ ${weather.tempMin}",
                      style: const TextStyle(
                        color: CustomColors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
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
          gridCard(Icons.speed_outlined, "pressão", "${weather.pressure!} mb"),
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
            fontSize: 16,
          ),
        ),
        Text(
          type,
          style: const TextStyle(
            color: CustomColors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget fiveDaysCards() {
    return StreamBuilder<FiveDaysModel>(
      stream: fiveDaysViewmodel.fiveDaysController,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return const ShimmerAnimation();
        } else if (snapshot.hasError) {
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
              const SizedBox(height: 20),
              lineGraphic(fiveDays.list!),
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
          final dateP = parts[0];
          final time = parts[1];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.5),
            child: Container(
              height: heightQ * 0.29,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: date == dateP ? CustomColors.blue : CustomColors.white,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "hoje",
                    style: TextStyle(
                      color: CustomColors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    dateP.substring(5),
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    time.substring(0, 5),
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${(day.tempMax)!.toStringAsFixed(0)}° △",
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${(day.tempMin)!.toStringAsFixed(0)}° ▽",
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 20,
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
          final dateP = parts[0];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.5),
            child: Container(
              height: heightQ * 0.29,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: CustomColors.white,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    dateP.substring(5),
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${(days.tempMax)!.toStringAsFixed(1)}° △",
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${(days.tempMin)!.toStringAsFixed(1)}° ▽",
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

  Widget lineGraphic(List<DayForecast> data) {
    return SfCartesianChart(
      primaryXAxis: const NumericAxis(
        title: AxisTitle(text: "X"),
      ),
      series: [
        LineSeries<DayForecast, num>(
          dataSource: data,
          xValueMapper: (DayForecast day, _) => day.time,
          yValueMapper: (DayForecast day, _) => day.tempMax,
        ),
        LineSeries<DayForecast, num>(
          dataSource: data,
          xValueMapper: (DayForecast day, _) => day.time,
          yValueMapper: (DayForecast day, _) => day.tempMin,
        ),
      ],
    );
  }
}
