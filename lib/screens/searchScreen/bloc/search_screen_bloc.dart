import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_event.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_state.dart';
import 'package:sky_search/services/api_services.dart';

class FlightSearchBloc extends Bloc<FlightSearchEvent, FlightSearchState> {
  FlightSearchBloc() : super(const FlightSearchState(loading: true)) {
    on<LoadAirports>(_onLoadAirports);
    on<SelectFromAirport>(
      (e, emit) => emit(state.copyWith(fromAirport: e.airport)),
    );
    on<SelectToAirport>(
      (e, emit) => emit(state.copyWith(toAirport: e.airport)),
    );
    on<SwapAirports>(_onSwapAirports);
    on<SelectDate>((e, emit) => emit(state.copyWith(departureDate: e.date)));
    on<UpdatePassengers>(
      (e, emit) => emit(state.copyWith(passengers: e.passengers)),
    );
  }

  Future<void> _onLoadAirports(
    LoadAirports event,
    Emitter<FlightSearchState> emit,
  ) async {
    try {
      final data = await AirportService.fetchAirports();
      emit(state.copyWith(airports: data, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void _onSwapAirports(SwapAirports event, Emitter<FlightSearchState> emit) {
    emit(
      state.copyWith(
        fromAirport: state.toAirport,
        toAirport: state.fromAirport,
      ),
    );
  }
}
