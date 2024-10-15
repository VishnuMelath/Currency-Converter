import 'package:currencyconverter/widgets/amout_field_widget.dart';
import 'package:flutter/material.dart';
import 'currency_field.dart';

class ColumnLayout extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController fromcontroller;
  final TextEditingController tocontroller;
  final List<String> currencies;
  const ColumnLayout(
      {super.key,
      required this.controller,
      required this.fromcontroller,
      required this.tocontroller,
      required this.currencies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AmountField(
            controller: controller,
          ),
          const SizedBox(height: 16),
          CurrencyField(
            currencies: currencies,
            label: 'from',
            controller: fromcontroller,
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          CurrencyField(
            currencies: currencies,
            label: 'to',
            controller: tocontroller,
          ),
        ],
      ),
    );
  }
}
