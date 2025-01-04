class WeatherModel {
  WeatherModel({
    this.base,
    this.main,
    this.visibility,
    this.dt,
    this.timeZone,
    this.id,
    this.name,
    this.cod,
    this.coord,
    this.weather,
    this.wind,
    this.rain,
    this.clouds,
    this.sys,
  });

  final Map<String, dynamic>? coord;
  final List<dynamic>? weather;
  final String? base;
  final Map<String, dynamic>? main;
  final num? visibility;
  final num? dt;
  final Map<String, dynamic>? wind;
  final Map<String, dynamic>? rain;
  final Map<String, dynamic>? clouds;
  final Map<String, dynamic>? sys;
  final num? timeZone;
  final num? id;
  final String? name;
  final num? cod;

  double? get latitude => coord?["lat"] as double;
  double? get longitude => coord?["lon"] as double;

  double? get temperature => main?["temp"] as double;
  double? get feelsLike => main?["feels_like"] as double;
  double? get tempMin => main?["temp_min"] as double;
  double? get tempMax => main?["temp_max"] as double;
  double? get pressure => main?["pressure"] as double;
  double? get humidity => main?["humidity"] as double;

  double? get windSpeed => wind?["wind_speed"] as double;

  double? get precipitation => rain?["1h"] as double;

  double? get cloudsPercent => clouds?["all"] as double;

  String? get country => sys?["country"] as String;
  double? get sunRise => sys?["sunrise"] as double;
  double? get sunSet => sys?["sunset"] as double;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        coord: json["coord"],
        weather: json["weather"],
        base: json["base"],
        main: json["main"],
        visibility: json["visibility"],
        dt: json["dt"],
        wind: json["wind"],
        rain: json["rain"],
        clouds: json["clouds"],
        sys: json["sys"],
        timeZone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
      );
}
