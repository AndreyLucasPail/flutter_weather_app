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
}
