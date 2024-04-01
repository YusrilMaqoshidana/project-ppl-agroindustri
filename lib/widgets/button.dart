import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Button({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 400,
      child: ElevatedButton(
        style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.brown), // Ubah warna latar belakang tombol di sini
                ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        letterSpacing: 3,
                        color: Colors.white),),
      ),
    );
  }
}

