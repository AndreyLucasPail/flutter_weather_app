class WeatherModel {
  WeatherModel({
    this.lat,
    this.long,
    this.timezoneOffset,
    this.timeZone,
    this.current,
    this.minutely,
    this.hourly,
    this.daily,
    this.alerts,
  });

  final double? lat;
  final double? long;
  final int? timezoneOffset;
  final String? timeZone;
  final Map<String, dynamic>? current;
  final List<Map<String, dynamic>>? minutely;
  final List<Map<String, dynamic>>? hourly;
  final List<Map<String, dynamic>>? daily;
  final List<Map<String, dynamic>>? alerts;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        lat: json["lat"],
        long: json["long"],
        timezoneOffset: json["timezone_offset"],
        timeZone: json["timezone"],
        current: json["current"],
        minutely: json["minutely"],
        hourly: json["hourly"],
        daily: json["daily"],
        alerts: json["alerts"],
      );
}
