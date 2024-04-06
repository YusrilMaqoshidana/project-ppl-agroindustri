import 'package:flutter/material.dart';

class Gesture extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const Gesture({Key? key, required this.text, required this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(fontFamily: 'Inter',fontSize: 16, color: Colors.brown),
      ),
    );
  }
}
