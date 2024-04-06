import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/long_button.dart';
import 'package:gencoff_app/utils/input.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(left: 25, right: 25, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Lupa Password",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    letterSpacing: 3,
                  ),
                ),
                Image.asset(
                  'assets/images/forgot_password.png',
                  width: 250,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputWithoutIcon(text: "Masukan Email", controller: _controllerEmail,),
                  ],
                ),
                SizedBox(
                  height: 220,
                ),
                LongButton(
                    text: "Konfirmasi",
                    onPressed: () {
                      Navigator.pushNamed(context, "/recovery_password");
                    })
              ],
            ),
          ),
      ),
    );
  }
}
