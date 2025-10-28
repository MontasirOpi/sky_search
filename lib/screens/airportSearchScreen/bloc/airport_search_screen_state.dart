import 'package:equatable/equatable.dart';
import 'package:sky_search/models/airport_model.dart';

class AirportSearchState extends Equatable {
  final List<Airport> allAirports;
  final List<Airport> filteredAirports;
  final bool loading;
  final String query;

  const AirportSearchState({
    this.allAirports = const [],
    this.filteredAirports = const [],
    this.loading = false,
    this.query = '',
  });

  AirportSearchState copyWith({
    List<Airport>? allAirports,
    List<Airport>? filteredAirports,
    bool? loading,
    String? query,
  }) {
    return AirportSearchState(
      allAirports: allAirports ?? this.allAirports,
      filteredAirports: filteredAirports ?? this.filteredAirports,
      loading: loading ?? this.loading,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [allAirports, filteredAirports, loading, query];
}
