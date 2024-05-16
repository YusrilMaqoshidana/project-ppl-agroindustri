import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/widgets/input.dart';
import 'package:gencoff_app/widgets/long_button.dart';

class WifiManager extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.ref();
  WifiManager({super.key});
  final _ssidController = TextEditingController();
  final _passwordController = TextEditingController();

  void _inisialisasi() {
    try {
    databaseReference.child('wifi').set({
      'ssid': _ssidController.text.trim(),
      'password': _passwordController.text.trim()
    });
  } catch (e) {
    print("Error: $e");
  }
  }

  Widget _title() {
    return const Text(
      "Wi-fi Manager",
      style: TextStyle(
          fontFamily: "Inter", fontSize: 28, fontWeight: FontWeight.w700),
    );
  }

  Widget _input() {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(
        children: [
          InputWithoutIcon(text: "SSID", controller: _ssidController),
          const SizedBox(
            height: 10,
          ),
          InputPassword(text: "Kata sandi", controller: _passwordController)
        ],
      ),
    );
  }

  Widget buttonKirim() {
    return Container(
        margin: const EdgeInsets.all(25),
        child: LongButton(
            text: "Kirim",
            onPressed: () {
              _inisialisasi();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _title(),
            const SizedBox(
              height: 10,
            ),
            _input(),
            buttonKirim()
          ],
        ),
      ),
    );
  }
}
