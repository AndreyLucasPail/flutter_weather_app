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

  final List<Map<String, dynamic>>? list;
  final Map<String, dynamic>? city;
  final String? country;
  final num? population;
  final num? timeZone;
  final num? sunRise;
  final num? sunSet;

  factory FiveDaysModel.fromJson(Map<String, dynamic> json) => FiveDaysModel(
        list: json["list"],
        city: json["city"],
        population: json["population"],
        timeZone: json["timezone"],
        sunRise: json["sunrise"],
        sunSet: json["sunset"],
      );
}
