import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LongButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Colors.brown), // Ubah warna latar belakang tombol di sini
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
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
  const LongButtonNonAktif({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 400,
      child: ElevatedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
                color: Colors.grey), // Atur warna dan ketebalan garis di sini
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: 3,
              color: Colors.grey),
        ),
      ),
    );
  }
}
