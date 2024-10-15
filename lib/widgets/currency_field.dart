import 'package:flutter/material.dart';

class CurrencyField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final List<String> currencies;
  const CurrencyField(
      {super.key,
      required this.label,
      required this.controller,
      required this.currencies});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12)),
      ),
      items: currencies.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.toUpperCase()),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null || value!.trim() != '') {
          controller.text = value;
        }
      },
    );
  }
}
