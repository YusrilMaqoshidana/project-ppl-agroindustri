import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/long_button.dart';
import 'package:gencoff_app/utils/gesture_detector.dart';
import 'package:gencoff_app/utils/input.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _passwordConfirmController = TextEditingController();
  bool isSucces = true;
  void signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      _showSuccesDialog();
    } on FirebaseAuthException catch (e) {
      _showErrorDialog("${e.message}");
    }
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
          title: Text('Berhasil!'),
          content: Text("Sukses membuat akun"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, "/login"),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

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
                  InputWithoutIcon(
                    text: "Masukan Username",
                    controller: _userController,
                  ),
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
                  InputWithoutIcon(
                    text: "Masukan email",
                    controller: _emailController,
                  ),
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
                  InputPassword(
                    text: "Masukan password",
                    controller: _passwordController,
                  ),
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
                  InputPassword(
                    text: "Masukan password",
                    controller: _passwordConfirmController,
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              LongButton(
                  text: "Daftar",
                  onPressed: () {
                    if (_passwordConfirmController.text.trim() == _passwordController.text.trim()) {
                      signUp();
                    } else {
                      _showErrorDialog(
                          "Password dan konfirmasi password tidak sama");
                    }
                  }),
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
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
