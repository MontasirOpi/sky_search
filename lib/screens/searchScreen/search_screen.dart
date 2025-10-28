import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_event.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_state.dart';

import 'package:sky_search/widgets/airport_selector_widget.dart';

class FlightSearchScreen extends StatelessWidget {
  const FlightSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlightSearchBloc, FlightSearchState>(
      builder: (context, state) {
        if (state.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('SkySearch ✈'),
            backgroundColor: const Color(0xFF0047AB),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AirportSelector(
                  label: 'From',
                  icon: Icons.flight_takeoff,
                  selectedAirport: state.fromAirport,
                  airports: state.airports,
                  onSelect: (a) => context.read<FlightSearchBloc>().add(
                    SelectFromAirport(a),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.swap_vert, color: Color(0xFF0047AB)),
                  onPressed: () =>
                      context.read<FlightSearchBloc>().add(SwapAirports()),
                ),
                AirportSelector(
                  label: 'To',
                  icon: Icons.flight_land,
                  selectedAirport: state.toAirport,
                  airports: state.airports,
                  onSelect: (a) =>
                      context.read<FlightSearchBloc>().add(SelectToAirport(a)),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 6),
                        child: _buildCompactOptionTile(
                          icon: Icons.calendar_today,
                          title: 'Departure Date',
                          value: state.departureDate == null
                              ? 'Select date'
                              : DateFormat(
                                  'dd MMM yyyy',
                                ).format(state.departureDate!),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  state.departureDate ??
                                  DateTime.now().add(const Duration(days: 1)),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (picked != null) {
                              context.read<FlightSearchBloc>().add(
                                SelectDate(picked),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 6),
                        child: _buildCompactOptionTile(
                          icon: Icons.person,
                          title: 'Passengers',
                          value: '${state.passengers}',
                          onTap: () =>
                              _showPassengerSelector(context, state.passengers),
                        ),
                      ),
                    ),
                  ],
                ),

                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _searchFlights(context, state),
                    icon: const Icon(Icons.search, color: Colors.white),
                    label: const Text(
                      'Search Flights',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0047AB),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompactOptionTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF0047AB), size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPassengerSelector(BuildContext context, int currentPassengers) {
    int selectedPassengers = currentPassengers;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Passengers',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: selectedPassengers > 1
                          ? () => setState(() => selectedPassengers--)
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      '$selectedPassengers',
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: selectedPassengers < 9
                          ? () => setState(() => selectedPassengers++)
                          : null,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<FlightSearchBloc>().add(
                      UpdatePassengers(selectedPassengers),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0047AB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _searchFlights(BuildContext context, FlightSearchState state) {
    if (state.fromAirport == null ||
        state.toAirport == null ||
        state.departureDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Search Details'),
        content: Text('''
From: ${state.fromAirport!.displayName}
To: ${state.toAirport!.displayName}
Date: ${DateFormat('dd MMM yyyy').format(state.departureDate!)}
Passengers: ${state.passengers}
        '''),
      ),
    );
  }
}
