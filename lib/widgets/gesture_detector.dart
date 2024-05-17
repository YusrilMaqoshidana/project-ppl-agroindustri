import 'package:flutter/material.dart';

class Gesture extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const Gesture({super.key, required this.text, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(fontFamily: 'Inter',fontSize: 16, color: Colors.blue),
      ),
    );
  }
}
