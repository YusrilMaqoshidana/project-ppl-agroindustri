import 'package:flutter/material.dart';
import 'package:gencoff_app/widgets/long_button.dart';

class SuccesAlertState extends StatelessWidget {
  const SuccesAlertState({super.key, required this.message, required this.onPressed});

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Berhasil",
        style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.green),
      ),
      content: SizedBox(
        height: 180,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Image.asset('assets/images/succes.png', width: 80,),
            const SizedBox(height: 20,),
            Text(message, style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black),
                textAlign: TextAlign.center
                ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 20,right: 20),
          child: LongButton(text: 'OK',onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class FailAlertState extends StatelessWidget {
  const FailAlertState({super.key, required this.message, required this.onPressed});

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Gagal",
        style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.red),
      ),
      content: SizedBox(
        height: 180,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Image.asset('assets/images/fail.png', width: 80,),
            const SizedBox(height: 20,),
            Text(message, style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black),
                textAlign: TextAlign.center
                ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 20,right: 20),
          child: LongButton(text: 'OK',onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class ValidationState extends StatelessWidget {
  const ValidationState({super.key, required this.message, required this.onPressed});

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 180,
        child: Column(
        children: [
          const SizedBox(height: 20,),
          Image.asset('assets/images/validasi.png', width: 80,),
          const SizedBox(height: 20,),
          Text(message, style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w600),
              textAlign: TextAlign.center
              ),
        ],
              ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
        const SizedBox(width: 10,),
        TextButton(onPressed: onPressed, child: const Text("Iya")),
      ],
    );
  }
}
