import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_event.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_state.dart';
import 'package:sky_search/widgets/airport_selector_widget.dart';

class FlightInfoCard extends StatelessWidget {
  final FlightSearchState state;

  const FlightInfoCard({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // From Airport
          Expanded(
            child: AirportSelector(
              label: 'Flying from?',
              selectedAirport: state.fromAirport,
              airports: state.airports,
              onSelect: (a) =>
                  context.read<FlightSearchBloc>().add(SelectFromAirport(a)),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1a1a2e),
              ),
              labelStyle: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9ca3af),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Swap Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () => context.read<FlightSearchBloc>().add(SwapAirports()),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFf0f4ff),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFe0e7ff), width: 1),
                ),
                child: const Icon(
                  Icons.swap_horiz_rounded,
                  color: Color(0xFF4f46e5),
                  size: 20,
                ),
              ),
            ),
          ),
          // To Airport
          Expanded(
            child: AirportSelector(
              label: 'Going to?',
              selectedAirport: state.toAirport,
              airports: state.airports,
              onSelect: (a) =>
                  context.read<FlightSearchBloc>().add(SelectToAirport(a)),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1a1a2e),
              ),
              labelStyle: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9ca3af),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
