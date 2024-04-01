import 'package:flutter/material.dart';
import 'package:gencoff_app/widgets/button.dart';
import 'package:gencoff_app/widgets/gesture_detector.dart';
import 'package:gencoff_app/widgets/input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "LOGIN",
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 28,
              letterSpacing: 3,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset('../assets/images/logo.png', width: 120),
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: Column(
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
                InputWithoutIcon(text: "Masukan Username"),
                SizedBox(height: 10),
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
                InputPassword(text: "Masukan Password"),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Mengatur teks di ujung kanan
            children: [
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Gesture(text: "Lupa password?", onTap: () {})),
            ],
          ),
          SizedBox(height: 150),
          Button(
            text: "LOGIN",
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Belom punya akun owner?",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 5,
              ),
              Gesture(
                text: "Register",
                onTap: () {},
              )
            ],
          )
          // ElevatedButton(
          //   child: Text("Go to Forgot Password"),
          //   onPressed: (){
          //   Navigator.pushNamed(context, '/forgot_password');
          //   },
          // ),
        ],
      ),
    );
  }
}
