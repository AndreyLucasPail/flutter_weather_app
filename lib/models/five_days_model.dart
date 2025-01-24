class FiveDaysModel {
  FiveDaysModel({
    this.city,
    this.country,
    this.population,
    this.timeZone,
    this.sunRise,
    this.sunSet,
    this.list,
  });

  final List<DayForecast>? list;
  final Map<String, dynamic>? city;
  final String? country;
  final num? population;
  final num? timeZone;
  final num? sunRise;
  final num? sunSet;

  factory FiveDaysModel.fromJson(Map<String, dynamic> json) => FiveDaysModel(
        list: (json["list"] as List<dynamic>?)!
            .map((item) => DayForecast.fromJson(item as Map<String, dynamic>))
            .toList(),
        city: json["city"],
        population: json["population"],
        timeZone: json["timezone"],
        sunRise: json["sunrise"],
        sunSet: json["sunset"],
      );

  List<DayForecast> getPerHourForecast() {
    final List<DayForecast> perHourList = list!
        .where((forecast) => forecast.dtTxt!.endsWith("12:00:00"))
        .toList();

    return perHourList;
  }
}

class DayForecast {
  DayForecast({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  final num? dt;
  final Map<String, dynamic>? main;
  final List<dynamic>? weather;
  final Map<String, dynamic>? clouds;
  final Map<String, dynamic>? wind;
  final num? visibility;
  final num? pop;
  final Map<String, dynamic>? rain;
  final Map<String, dynamic>? sys;
  final String? dtTxt;

  String? get climate => weather![0]["main"] as String;

  num? get temperature => main!["temp"];
  num? get feelsLike => main!["feels_like"];
  num? get tempMin => main!["temp_min"];
  num? get tempMax => main!["temp_max"];
  num? get pressure => main!["pressure"];
  num? get humidity => main!["humidity"];

  String? get isRain => weather![0]["main"];

  num? get cloudsPercent => clouds!["all"];

  num? get speed => wind!["speed"];
  num? get deg => wind!["deg"];
  num? get gust => wind!["gust"];

  Map<String, dynamic>? get format => formattedDateAndTime();
  String? get formatDate => format!["formatDate"];
  String? get date => format!["date"];
  String? get time => format!["time"];

  factory DayForecast.fromJson(Map<String, dynamic> json) => DayForecast(
        dt: json["dt"],
        main: json["main"],
        weather: json["weather"],
        clouds: json["clouds"],
        wind: json["wind"],
        visibility: json["visibility"],
        pop: json["pop"],
        rain: json["rain"],
        sys: json["sys"],
        dtTxt: json["dt_txt"],
      );

  Map<String, dynamic> formattedDateAndTime() {
    final List<String> parts = dtTxt!.split(" ");
    final date = parts[0]; //yyyy-MM-dd
    final time = parts[1].substring(0, 5); //15:00
    final formatDate =
        "${date.substring(8, 10)}/${date.substring(5, 7)}"; //dd/MM

    Map<String, dynamic> format = {
      "date": date,
      "time": time,
      "formatDate": formatDate,
    };

    return format;
  }
}
