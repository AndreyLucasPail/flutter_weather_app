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
    print(">>>>>>>>>>>>>>>>>>>${widget.cityName}<<<<<<<<<<<<<<<<<<<<<");
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
          // city = widget.cityName!;
          final weather = snapshot.data;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customAppBar(weather!),
                  const SizedBox(height: 20),
                  infoCircle(weather),
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
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.white,
          ),
        ),
      ],
    );
  }

  Widget infoCircle(SearchWeatherModel weather) {
    return Container(
      height: 200,
      width: 200,
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
            height: 50,
            width: 50,
            child: SvgPicture.asset(
              currentClimate(weather.climate!),
            ),
          ),
          Text(
            "${weather.temperature!.toStringAsFixed(1)} C°",
            style: const TextStyle(
              color: CustomColors.white,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
