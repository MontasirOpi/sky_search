import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_search/models/airport_model.dart';
import 'package:sky_search/screens/airportSearchScreen/bloc/airport_search_screen_bloc.dart';
import 'package:sky_search/screens/airportSearchScreen/bloc/airport_search_screen_event.dart';
import 'package:sky_search/screens/airportSearchScreen/bloc/airport_search_screen_state.dart';

class AirportSearchScreen extends StatelessWidget {
  final List<Airport> airports;
  final Function(Airport) onSelect;

  const AirportSearchScreen({
    Key? key,
    required this.airports,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AirportSearchBloc()..add(LoadAirports(airports)),
      child: BlocBuilder<AirportSearchBloc, AirportSearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF0047AB),
              foregroundColor: Colors.white,
              elevation: 0,
              title: const Text('Select Airport'),
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search by city, airport or code',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: state.query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => context
                                  .read<AirportSearchBloc>()
                                  .add(SearchAirport('')),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onChanged: (value) => context.read<AirportSearchBloc>().add(
                      SearchAirport(value),
                    ),
                  ),
                ),
                Expanded(
                  child: state.filteredAirports.isEmpty
                      ? const Center(child: Text('No airports found'))
                      : ListView.builder(
                          itemCount: state.filteredAirports.length,
                          itemBuilder: (context, index) {
                            final airport = state.filteredAirports[index];
                            return ListTile(
                              leading: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF0047AB,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.local_airport,
                                  color: Color(0xFF0047AB),
                                ),
                              ),
                              title: Text(
                                airport.cityName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                '${airport.airportName}\n${airport.countryName}',
                              ),
                              trailing: Text(
                                airport.code,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF0047AB),
                                ),
                              ),
                              isThreeLine: true,
                              onTap: () => onSelect(airport),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
