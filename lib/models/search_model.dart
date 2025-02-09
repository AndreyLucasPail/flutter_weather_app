class SearchWeatherModel {
  SearchWeatherModel({
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

  num? get latitude => coord?["lat"] as num;
  num? get longitude => coord?["lon"] as num;

  String? get description => weather![0]["description"] as String;
  String? get climate => weather![0]["main"] as String;

  num? get temperature => main?["temp"] as num;
  num? get feelsLike => main?["feels_like"] as num;
  num? get tempMin => main?["temp_min"] as num;
  num? get tempMax => main?["temp_max"] as num;
  num? get pressure => main?["pressure"] as num;
  num? get humidity => main?["humidity"] as num;
  num? get seaLevel => main?["sea_level"] as num;
  num? get gnrdLevel => main?["grnd_level"];

  num? get windSpeed => wind?["speed"] as num;
  num? get windDirec => wind?["deg"] as num;

  num? get precipitation => rain?["1h"] as num;

  num? get cloudsPercent => clouds?["all"] as num;
  String? get country => sys?["country"] as String;
  num? get sunRise => sys?["sunrise"] as num;
  num? get sunSet => sys?["sunset"] as num;

  factory SearchWeatherModel.fromJson(Map<String, dynamic> json) =>
      SearchWeatherModel(
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
