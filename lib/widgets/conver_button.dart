import 'package:flutter/material.dart';

class ConvertButton extends StatelessWidget {
  final VoidCallback callback;
  const ConvertButton({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.blue)),
      child: const Text(
        'Convert',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
