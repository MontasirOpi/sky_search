import 'package:equatable/equatable.dart';
import 'package:sky_search/models/airport_model.dart';

abstract class FlightSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAirports extends FlightSearchEvent {}

class SelectFromAirport extends FlightSearchEvent {
  final Airport airport;
  SelectFromAirport(this.airport);
}

class SelectToAirport extends FlightSearchEvent {
  final Airport airport;
  SelectToAirport(this.airport);
}

class SwapAirports extends FlightSearchEvent {}

class SelectDate extends FlightSearchEvent {
  final DateTime date;
  SelectDate(this.date);
}

class UpdatePassengers extends FlightSearchEvent {
  final int passengers;
  UpdatePassengers(this.passengers);
}
