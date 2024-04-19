import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gencoff_app/utils/input.dart';
import 'package:gencoff_app/utils/long_button.dart';

class WifiManager extends StatelessWidget {
  WifiManager({super.key});
  final _ssidController = TextEditingController();
  final _passwordController = TextEditingController();
  Widget _title() {
    return Text(
      "Wi-fi Manager",
      style: TextStyle(
          fontFamily: "Inter", fontSize: 28, fontWeight: FontWeight.w700),
    );
  }

  Widget _input() {
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(
        children: [
          InputWithoutIcon(text: "SSID", controller: _ssidController),
          SizedBox(
            height: 10,
          ),
          InputPassword(text: "Kata sandi", controller: _passwordController)
        ],
      ),
    );
  }

  Widget buttonKirim() {
    return Container(margin: EdgeInsets.all(25),child: LongButton(text: "Kirim", onPressed: () {}));
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
            SizedBox(
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
