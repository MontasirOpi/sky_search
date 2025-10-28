import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_event.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_state.dart';
import 'package:sky_search/screens/searchScreen/widgets/flight_info_card.dart';
import 'package:sky_search/screens/searchScreen/widgets/passenger_section_bottom_sheet.dart';
import 'package:sky_search/screens/searchScreen/widgets/payment_section.dart';

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
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text('SkySearch ✈'),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              FlightInfoCard(state: state),
              const SizedBox(height: 12),
              _buildDateCard(context, state),
              const SizedBox(height: 12),
              _buildPassengerCard(context, state),
              const SizedBox(height: 12),
              _buildPaymentCard(),
              const SizedBox(height: 12),
              _buildCurrencyCard(),
              const SizedBox(height: 16),
              _buildTagButtons(),
              const SizedBox(height: 24),
              _buildSearchButton(context, state),
            ],
          ),
        );
      },
    );
  }

  // -------------------- DATE CARD --------------------
  Widget _buildDateCard(BuildContext context, FlightSearchState state) {
    return _sectionCard(
      child: ListTile(
        onTap: () => _pickDate(context, state),
        title: const Text(
          'Departure',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        subtitle: Text(
          state.departureDate == null
              ? 'Select date'
              : DateFormat('dd MMM').format(state.departureDate!),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.calendar_today_outlined, color: Colors.blue),
      ),
    );
  }

  // -------------------- PASSENGER CARD --------------------
  Widget _buildPassengerCard(BuildContext context, FlightSearchState state) {
    return _sectionCard(
      child: ListTile(
        onTap: () => _showPassengers(context, state.passengers),
        title: const Text(
          'Travellers + Special Fares',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        subtitle: Text(
          '${state.passengers} Passenger(s)',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  // -------------------- PAYMENT CARD --------------------
  Widget _buildPaymentCard() {
    return _sectionCard(
      child: PaymentSelector(
        selectedOption: 'Cash',
        onSelected: (value) {
          // Handle selected payment option here
          print('Selected payment: $value');
        },
      ),
    );
  }

  // -------------------- CURRENCY CARD --------------------
  Widget _buildCurrencyCard() {
    return _sectionCard(
      child: ListTile(
        title: const Text(
          'Currency',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        subtitle: const Text(
          'taka',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  // -------------------- TAG BUTTONS --------------------
  Widget _buildTagButtons() {
    return Wrap(
      spacing: 8,
      children: [
        _chip('6Exclusive'),
        _chip('Students'),
        _chip('Family & Friends'),
      ],
    );
  }

  Widget _chip(String label) {
    return Chip(
      label: Text(label),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.grey[200],
    );
  }

  // -------------------- SEARCH BUTTON --------------------
  Widget _buildSearchButton(BuildContext context, FlightSearchState state) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () => _searchFlights(context, state),
        icon: const Icon(Icons.search),
        label: const Text('Search Flights'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // -------------------- REUSABLE SECTION CARD --------------------
  Widget _sectionCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  // -------------------- PASSENGER SELECTOR --------------------
  void _showPassengers(BuildContext context, int current) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => PassengerSelector(currentPassengers: current),
    );
  }

  // -------------------- DATE PICKER --------------------
  Future<void> _pickDate(BuildContext context, FlightSearchState state) async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          state.departureDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      context.read<FlightSearchBloc>().add(SelectDate(picked));
    }
  }

  // -------------------- SEARCH FUNCTION --------------------
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
        content: Text('''From: ${state.fromAirport!.displayName}
To: ${state.toAirport!.displayName}
Date: ${DateFormat('dd MMM yyyy').format(state.departureDate!)}
Passengers: ${state.passengers}'''),
      ),
    );
  }
}
