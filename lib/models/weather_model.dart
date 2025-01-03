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
