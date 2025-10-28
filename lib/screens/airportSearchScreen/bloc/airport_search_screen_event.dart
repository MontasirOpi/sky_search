import 'package:equatable/equatable.dart';

abstract class AirportSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAirports extends AirportSearchEvent {
  final List<dynamic> airports;
  LoadAirports(this.airports);

  @override
  List<Object?> get props => [airports];
}

class SearchAirport extends AirportSearchEvent {
  final String query;
  SearchAirport(this.query);

  @override
  List<Object?> get props => [query];
}
