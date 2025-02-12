import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_app/models/current_weather_model.dart';
import 'package:flutter_weather_app/models/five_days_model.dart';
import 'package:flutter_weather_app/utils/colors/custom_colors.dart';
import 'package:flutter_weather_app/mixin/home_mixin.dart';
import 'package:flutter_weather_app/views/city_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const tag = "/homeView";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.nigthBlue,
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
              color: CustomColors.nigthBlue,
            ),
            child: SingleChildScrollView(
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
                  const SizedBox(height: 20),
                  bottomText(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget today(CurrentWeatherModel? weather) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: Stack(
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
                      dateBr,
                      style: const TextStyle(
                        color: CustomColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Positioned(
                  right: 10,
                  child: popUpContainer(),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width * 0.7,
            color: CustomColors.white,
          ),
          Text(
            weather.description!,
            style: const TextStyle(
              color: CustomColors.grey400,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: SvgPicture.asset(currentClimate(weather.climate!)),
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
      ),
    );
  }

  Widget todayInfosCard(CurrentWeatherModel? weather) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: heightQ * 0.3,
        decoration: BoxDecoration(
          color: CustomColors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: GridView(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          children: [
            gridCard(Icons.air, "vento", "${weather!.windSpeed!} m/s"),
            gridCard(
                Icons.speed_outlined, "pressão", "${weather.pressure!} mb"),
            gridCard(
                Icons.invert_colors_on, "Humidade", "${weather.humidity!}%"),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
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
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Previsão para os proximos 5 dias",
                    style: TextStyle(
                      color: CustomColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  line(),
                  fiveDaysInfo(todayForecast),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                    line(),
                    const SizedBox(height: 20),
                    threeHourInfo(fiveDays),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: heightQ * 0.29,
              width: 120,
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 4.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color:
                      date == day.date ? CustomColors.blue : CustomColors.white,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    day.time!,
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 30,
                    child: SvgPicture.asset(
                      currentClimate(day.climate!),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    day.formatDate!,
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${(day.temperature)!.toStringAsFixed(0)}°C",
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 20,
                    ),
                  ),
                  Flexible(
                    child: AutoSizeText(
                      "${day.description}",
                      textAlign: TextAlign.center,
                      minFontSize: 15,
                      style: const TextStyle(
                        color: CustomColors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.air_outlined,
                        color: CustomColors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${day.speed} Km/h",
                        style: const TextStyle(
                          color: CustomColors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
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
      child: SizedBox(
        height: heightQ * 0.25,
        child: Row(
          children: dayForecast!.map((days) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: heightQ * 0.15,
                width: 75,
                decoration: BoxDecoration(
                  color: CustomColors.nigthBlue,
                  borderRadius: BorderRadius.circular(35.0),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.white.withOpacity(0.25),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(-10.0, -10.0),
                    ),
                    BoxShadow(
                      color: CustomColors.black.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(10.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 30,
                      child: SvgPicture.asset(
                        currentClimate(days.climate!),
                      ),
                    ),
                    Text(
                      "${(days.temperature)!.toStringAsFixed(1)}°C",
                      style: const TextStyle(
                        color: CustomColors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      days.formatDate!,
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
      ),
    );
  }

  Widget line() {
    return Container(
      height: 1,
      width: widthQ * 0.9,
      color: CustomColors.grey,
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

  Widget popUpContainer() {
    return StreamBuilder<bool>(
      stream: expandedViewmodel.isExpandedStream,
      initialData: false,
      builder: (context, snapshot) {
        bool isExpanded = snapshot.data ?? false;
        return GestureDetector(
          onTap: () {
            expandedViewmodel.toggledExpansion();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: isExpanded ? 60 : 50,
            width: isExpanded ? widthQ * 0.8 : 50,
            decoration: BoxDecoration(
              color: CustomColors.nigthBlue,
              boxShadow: [
                BoxShadow(
                  color: CustomColors.white.withOpacity(0.25),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(-10.0, -10.0),
                ),
                BoxShadow(
                  color: CustomColors.black.withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(10.0, 10.0),
                ),
              ],
              borderRadius: BorderRadius.circular(isExpanded ? 16.0 : 25.0),
            ),
            child: isExpanded
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: searchInput(),
                  )
                : const Icon(
                    Icons.search,
                    color: CustomColors.white,
                  ),
          ),
        );
      },
    );
  }

  Widget searchInput() {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: searchController,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (value) {
              expandedViewmodel.toggledExpansion();
              Navigator.pushNamed(
                context,
                CityView.tag,
                arguments: CityViewArgs(
                  cityName: searchController.text,
                ),
              );
              searchController.clear();
            },
            decoration: const InputDecoration(
              hintText: "Pesquisar cidade",
              hintStyle: TextStyle(
                color: CustomColors.white,
              ),
            ),
            style: const TextStyle(
              color: CustomColors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            // setState(() {
            //   isExpanded = !isExpanded;
            // });
            expandedViewmodel.toggledExpansion();
          },
          icon: const Icon(
            Icons.close_rounded,
            color: CustomColors.white,
          ),
        ),
      ],
    );
  }
}
