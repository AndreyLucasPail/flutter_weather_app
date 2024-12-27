class DataModel {
  DataModel(
    this.lat,
    this.long,
    this.timezoneOffset,
    this.timeZone,
    this.current,
    this.minutely,
    this.hourly,
    this.daily,
    this.alerts,
  );

  final int? lat;
  final int? long;
  final int? timezoneOffset;
  final String? timeZone;
  final List<Map<String, dynamic>> current;
  final List<Map<String, dynamic>> minutely;
  final List<Map<String, dynamic>> hourly;
  final List<Map<String, dynamic>> daily;
  final List<Map<String, dynamic>> alerts;
}
