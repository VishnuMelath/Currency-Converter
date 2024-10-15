import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  final TextEditingController controller;
  const AmountField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Amount',
        border:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
