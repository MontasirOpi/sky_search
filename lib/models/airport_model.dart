class Airport {
  final String name;
  final String city;
  final String country;
  final String iata;

  Airport({
    required this.name,
    required this.city,
    required this.country,
    required this.iata,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      iata: json['iata'] ?? '',
    );
  }

  String get displayName => '$city ($iata)';
  String get fullName => '$name, $city';
}
