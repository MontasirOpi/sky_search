import 'package:flutter/material.dart';

class PaymentSelector extends StatefulWidget {
  final String? selectedOption;
  final Function(String) onSelected;

  const PaymentSelector({
    Key? key,
    this.selectedOption,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<PaymentSelector> createState() => _PaymentSelectorState();
}

class _PaymentSelectorState extends State<PaymentSelector> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selectedOption ?? 'Cash';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pay with',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _radioOption('Cash'),
            const SizedBox(width: 16),
            _radioOption('Bank Transfer'),
          ],
        ),
      ],
    );
  }

  Widget _radioOption(String label) {
    bool isSelected = selected == label;
    return InkWell(
      onTap: () {
        setState(() {
          selected = label;
        });
        widget.onSelected(label);
      },
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? Colors.blue : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.blue : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
