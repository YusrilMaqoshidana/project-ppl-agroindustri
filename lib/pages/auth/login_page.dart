import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/long_button.dart';
import 'package:gencoff_app/utils/gesture_detector.dart';
import 'package:gencoff_app/utils/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gencoff_app/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isSucces = true;

  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim());
          _showSuccesDialog();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _showErrorDialog("${e.message}");
      });
    }
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    setState(() {
      isSucces = !isSucces;
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccesDialog() {
    setState(() {
      isSucces = !isSucces;
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Masuk berhasil!'),
          content: Text("Selamat anda berhasil masuk"),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25, top: 100, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Masuk",
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
              Image.asset('assets/images/logo.png', width: 100),
              SizedBox(
                height: 60,
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
                  InputWithoutIcon(
                    text: "Masukan email",
                    controller: _controllerEmail,
                  ),
                  SizedBox(height: 20),
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
                  InputPassword(
                    text: "Masukan password",
                    controller: _controllerPassword,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Mengatur teks di ujung kanan
                children: [
                  Gesture(
                      text: "Lupa password?",
                      onTap: () {
                        Navigator.pushNamed(context, '/forgot_password');
                      }),
                ],
              ),
              SizedBox(height: 140),
              LongButton(
                text: "Masuk",
                onPressed: () {
                  signInWithEmailAndPassword();
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belom punya akun?",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Gesture(
                    text: "Daftar",
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
