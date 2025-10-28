import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_event.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_state.dart';
import 'package:sky_search/widgets/airport_selector_widget.dart';

class FlightInfoCard extends StatelessWidget {
  final FlightSearchState state;

  const FlightInfoCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
              onSelect: (a) {
                if (state.toAirport != null &&
                    a.code == state.toAirport!.code) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Departure and destination cannot be the same',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                context.read<FlightSearchBloc>().add(SelectFromAirport(a));
              },
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: InkWell(
              onTap: () => context.read<FlightSearchBloc>().add(SwapAirports()),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366f1), Color(0xFF4f46e5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.swap_horiz_rounded,
                  color: Colors.white,
                  size: 22,
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
              onSelect: (a) {
                if (state.fromAirport != null &&
                    a.code == state.fromAirport!.code) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Departure and destination cannot be the same',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                context.read<FlightSearchBloc>().add(SelectToAirport(a));
              },
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
