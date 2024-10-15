import 'package:currencyconverter/widgets/amout_field_widget.dart';
import 'package:currencyconverter/widgets/currency_field.dart';
import 'package:flutter/material.dart';

class RowLayout extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController fromcontroller;
  final TextEditingController tocontroller;
  final List<String> currencies;
  const RowLayout({
    super.key,
    required this.controller,
    required this.fromcontroller,
    required this.tocontroller,
    required this.currencies,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: AmountField(
              controller: controller,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: CurrencyField(
              currencies: currencies,
              label: 'from',
              controller: fromcontroller,
            ),
          ),
          const SizedBox(width: 16),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: CurrencyField(
              currencies: currencies,
              label: 'to',
              controller: tocontroller,
            ),
          ),
        ],
      ),
    );
  }
}
