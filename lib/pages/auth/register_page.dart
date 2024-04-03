import 'package:flutter/material.dart';
import 'package:gencoff_app/widgets/button.dart';
import 'package:gencoff_app/widgets/gesture_detector.dart';
import 'package:gencoff_app/widgets/input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
                fontSize: 28,
                letterSpacing: 3,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username"),
                SizedBox(
                  height: 5,
                ),
                InputWithoutIcon(text: "Masukan Username"),
                SizedBox(
                  height: 20,
                ),
                Text("Email"),
                SizedBox(
                  height: 5,
                ),
                InputWithoutIcon(text: "Email"),
                SizedBox(
                  height: 20,
                ),
                Text("Password"),
                SizedBox(
                  height: 5,
                ),
                InputPassword(text: "Masukan Password"),
                SizedBox(
                  height: 20,
                ),
                Text("Konfirmasi Password"),
                SizedBox(
                  height: 5,
                ),
                InputPassword(text: "Masukan Password"),
              ],
            ),
            SizedBox(
              height: 120,
            ),
            Button(text: "Daftar", onPressed: () {}),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sudah punya akun?"),
                Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Gesture(
                        text: "Login",
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        }))
              ],
            )
          ],
        ),
      ),
    );
  }
}
