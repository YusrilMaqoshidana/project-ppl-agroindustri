import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LongButton({super.key, required this.text, required this.onPressed});

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
        child: Text(
          text,
          style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: 3,
              color: Colors.white),
        ),
      ),
    );
  }
}

class LongButtonNonAktif extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const LongButtonNonAktif({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 400,
      child: ElevatedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
                color: Colors.brown), // Atur warna dan ketebalan garis di sini
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: 3,
              color: Colors.brown),
        ),
      ),
    );
  }
}
