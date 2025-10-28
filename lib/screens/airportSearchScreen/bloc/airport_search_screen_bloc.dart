import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_search/models/airport_model.dart';
import 'package:sky_search/screens/airportSearchScreen/bloc/airport_search_screen_event.dart';
import 'package:sky_search/screens/airportSearchScreen/bloc/airport_search_screen_state.dart';

class AirportSearchBloc extends Bloc<AirportSearchEvent, AirportSearchState> {
  AirportSearchBloc() : super(const AirportSearchState()) {
    on<LoadAirports>(_onLoadAirports);
    on<SearchAirport>(_onSearchAirport);
  }

  void _onLoadAirports(LoadAirports event, Emitter<AirportSearchState> emit) {
    emit(
      state.copyWith(
        allAirports: List<Airport>.from(event.airports),
        filteredAirports: List<Airport>.from(event.airports),
        loading: false,
      ),
    );
  }

  void _onSearchAirport(SearchAirport event, Emitter<AirportSearchState> emit) {
    final query = event.query.toLowerCase();
    final filtered = state.allAirports.where((airport) {
      return airport.cityName.toLowerCase().contains(query) ||
          airport.airportName.toLowerCase().contains(query) ||
          airport.code.toLowerCase().contains(query) ||
          airport.countryName.toLowerCase().contains(query) ||
          airport.searchContents.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(filteredAirports: filtered, query: event.query));
  }
}
