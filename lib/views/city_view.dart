import 'package:flutter/material.dart';
import 'package:flutter_weather_app/mixin/city_mixin.dart';
import 'package:flutter_weather_app/models/current_weather_model.dart';
import 'package:flutter_weather_app/utils/colors/custom_colors.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.nigthBlue,
      body: body(),
    );
  }

  Widget body() {
    return StreamBuilder<CurrentWeatherModel>(
      stream: weatherViewmodel.byCityStream,
      builder: (context, snapshot) {
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          city = widget.cityName!;
          final weather = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customAppBar(),
                const SizedBox(height: 20),
                infoCircle(),
              ],
            ),
          );
        }
      },
    );
  }

  Widget customAppBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.white,
          ),
        ),
      ],
    );
  }

  Widget infoCircle() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.white,
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
    );
  }
}
