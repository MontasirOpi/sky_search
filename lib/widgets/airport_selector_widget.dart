import 'package:flutter/material.dart';
import 'package:sky_search/models/airport_model.dart';
import 'package:sky_search/screens/airportSearchScreen/airport_search_screen.dart';

class AirportSelector extends StatelessWidget {
  final String label;
  final IconData icon;
  final Airport? selectedAirport;
  final List<Airport> airports;
  final Function(Airport) onSelect;

  const AirportSelector({
    Key? key,
    required this.label,
    required this.icon,
    required this.selectedAirport,
    required this.airports,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showAirportSearch(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0047AB).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF0047AB), size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedAirport?.displayName ?? 'Select airport',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  void _showAirportSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AirportSearchScreen(
          airports: airports,
          onSelect: (airport) {
            onSelect(airport);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
