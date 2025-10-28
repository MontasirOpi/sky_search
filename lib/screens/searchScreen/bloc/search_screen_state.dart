import 'package:equatable/equatable.dart';
import 'package:sky_search/models/airport_model.dart';

class FlightSearchState extends Equatable {
  final List<Airport> airports;
  final Airport? fromAirport;
  final Airport? toAirport;
  final DateTime? departureDate;
  final int passengers;
  final bool loading;
  final String? error;

  const FlightSearchState({
    this.airports = const [],
    this.fromAirport,
    this.toAirport,
    this.departureDate,
    this.passengers = 1,
    this.loading = false,
    this.error,
  });

  FlightSearchState copyWith({
    List<Airport>? airports,
    Airport? fromAirport,
    Airport? toAirport,
    DateTime? departureDate,
    int? passengers,
    bool? loading,
    String? error,
  }) {
    return FlightSearchState(
      airports: airports ?? this.airports,
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
      departureDate: departureDate ?? this.departureDate,
      passengers: passengers ?? this.passengers,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    airports,
    fromAirport,
    toAirport,
    departureDate,
    passengers,
    loading,
    error,
  ];
}
