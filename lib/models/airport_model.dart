class Airport {
  final String code;
  final String airportName;
  final String cityName;
  final String cityCode;
  final String countryName;
  final String searchContents;

  Airport({
    required this.code,
    required this.airportName,
    required this.cityName,
    required this.cityCode,
    required this.countryName,
    required this.searchContents,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      code: json['code'] ?? '',
      airportName: json['airport_name'] ?? '',
      cityName: json['city_name'] ?? '',
      cityCode: json['city_code'] ?? '',
      countryName: json['country_name'] ?? '',
      searchContents: json['search_contents'] ?? '',
    );
  }

  String get displayName => '$cityName ($code)';
  String get fullName => '$airportName, $cityName';
}
