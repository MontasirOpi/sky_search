import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_state.dart';

class SearchDetailsDialog extends StatelessWidget {
  final FlightSearchState state;

  const SearchDetailsDialog({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Search Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // From
          Row(
            children: [
              const Icon(Icons.flight_takeoff, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  state.fromAirport!.displayName,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // To
          Row(
            children: [
              const Icon(Icons.flight_land, color: Colors.green),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  state.toAirport!.displayName,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Date
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.orange),
              const SizedBox(width: 12),
              Text(
                DateFormat('dd MMM yyyy').format(state.departureDate!),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Passengers
          Row(
            children: [
              const Icon(Icons.person, color: Colors.purple),
              const SizedBox(width: 12),
              Text(
                '${state.passengers} Passenger${state.passengers > 1 ? 's' : ''}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Close button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.blue,
              ),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}
