import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/long_button.dart';
import 'package:gencoff_app/utils/input.dart';

class RecoveryPasswordPage extends StatefulWidget {
  RecoveryPasswordPage({super.key});

  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final _passwordConfirmController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordConfirmController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 25, right: 25, bottom: 5),
            child: Column(
              children: [
                Text(
                  "Pemulihan Password",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password baru",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputPassword(
                      text: "Masukan Password",
                      controller: _passwordController,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Konfirmasi password",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputPassword(
                      text: "Masukan Password",
                      controller: _passwordConfirmController,
                    ),
                  ],
                ),
                SizedBox(
                  height: 260,
                ),
                LongButton(text: "Simpan", onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
