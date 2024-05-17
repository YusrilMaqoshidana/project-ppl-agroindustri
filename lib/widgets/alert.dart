import 'package:flutter/material.dart';
import 'package:gencoff_app/widgets/long_button.dart';

class SuccesAlertState extends StatelessWidget {
  const SuccesAlertState(
      {super.key, required this.message, required this.onPressed});

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
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/succes.png',
              width: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(message,
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                textAlign: TextAlign.center),
          ],
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: LongButton(
            text: 'OK',
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class FailAlertState extends StatelessWidget {
  const FailAlertState(
      {super.key, required this.message, required this.onPressed});

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
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/fail.png',
              width: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(message,
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                textAlign: TextAlign.center),
          ],
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: LongButton(
            text: 'OK',
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class ValidationState extends StatelessWidget {
  const ValidationState(
      {super.key, required this.message, required this.onPressed});

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 180,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/validasi.png',
              width: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(message,
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
          ],
        ),
      ),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.brown, width: 2), // Menambahkan border
                  ),
                  child: const Center(
                    child: Text(
                      "Tidak",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.brown),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              TextButton(
                onPressed: onPressed,
                child: Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.brown, // Menambahkan warna latar belakang
                  ),
                  child: const Center(
                    child: Text(
                      "Iya",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
