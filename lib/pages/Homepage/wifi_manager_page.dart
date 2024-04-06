import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gencoff_app/utils/input.dart';

class WifiManager extends StatelessWidget {
  WifiManager({super.key});
  final _ssidController = TextEditingController();
  final _passwordController = TextEditingController();
  Widget _title() {
    return Text("Wi-fi Manager");
  }

  Widget _input() {
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(
        children: [
          InputWithoutIcon(text: "SSID", controller: _ssidController),
          InputPassword(text: "Password", controller: _passwordController)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          children: [
            _title(),
          ],
        ),
      ),
    );
  }
}
