import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_bloc.dart';
import 'package:sky_search/screens/searchScreen/bloc/search_screen_event.dart';

class PassengerSelector extends StatefulWidget {
  final int currentPassengers;

  const PassengerSelector({Key? key, required this.currentPassengers})
    : super(key: key);

  @override
  State<PassengerSelector> createState() => _PassengerSelectorState();
}

class _PassengerSelectorState extends State<PassengerSelector> {
  int adult = 0;
  int senior = 0;
  int child = 0;
  int infant = 0;

  @override
  void initState() {
    super.initState();
    adult = widget.currentPassengers;
  }

  @override
  Widget build(BuildContext context) {
    int total = adult + senior + child + infant;

    Widget counterRow(
      String label,
      String subtitle,
      int value,
      VoidCallback onAdd,
      VoidCallback onRemove,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: value > 0 ? onRemove : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.blue,
                ),
                Text(
                  '$value',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: total < 9 ? onAdd : null,
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget fareChip(String label, {bool selected = false}) {
      return Chip(
        label: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: selected ? Colors.blue : Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      );
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Who are you travelling with?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Fare Chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                fareChip('6EExclusive', selected: true),
                fareChip('Students'),
                fareChip('Family & Friends'),
                fareChip('Unaccompanied Minor'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 18,
                  color: Colors.redAccent,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '6E Exclusive Fare selection will update the travel date to 7 days advance.',
                    style: TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                counterRow(
                  'Adult',
                  '(12 - 59 years)',
                  adult,
                  () => setState(() => adult++),
                  () => setState(() => adult--),
                ),
                counterRow(
                  'Senior Citizen',
                  '(60+ years)',
                  senior,
                  () => setState(() => senior++),
                  () => setState(() => senior--),
                ),
                counterRow(
                  'Children',
                  '(2 - 12 years)',
                  child,
                  () => setState(() => child++),
                  () => setState(() => child--),
                ),
                counterRow(
                  'Infant',
                  '(3 days - 2 years)',
                  infant,
                  () => setState(() => infant++),
                  () => setState(() => infant--),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$total Passenger${total > 1 ? 's' : ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<FlightSearchBloc>().add(
                      UpdatePassengers(total),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
