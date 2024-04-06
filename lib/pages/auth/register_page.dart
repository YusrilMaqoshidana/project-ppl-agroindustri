import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/long_button.dart';
import 'package:gencoff_app/utils/gesture_detector.dart';
import 'package:gencoff_app/utils/input.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Daftar",
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
                  Text(
                    "Username",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InputWithoutIcon(text: "Masukan Username", controller: _userController,),
                  SizedBox(
                    height: 10,
                  ),
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
                  InputWithoutIcon(text: "Masukan email", controller: _emailController,),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InputPassword(text: "Masukan password", controller: _passwordController,),
                  SizedBox(
                    height: 10,
                  ),
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
                  InputPassword(text: "Masukan password", controller: _passwordConfirmController,),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              LongButton(text: "Daftar", onPressed: () {}),
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
                          text: "Masuk",
                          onTap: () {
                            Navigator.pushNamed(context, "/login");
                          }))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
