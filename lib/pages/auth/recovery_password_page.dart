import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/button.dart';
import 'package:gencoff_app/utils/input.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({super.key});

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
                    InputPassword(text: "Masukan Password"),
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
                    InputPassword(text: "Masukan Password"),
                  ],
                ),
                SizedBox(
                  height: 260,
                ),
                Button(text: "Simpan", onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
