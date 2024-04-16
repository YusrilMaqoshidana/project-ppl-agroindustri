import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/alert.dart';
import 'package:gencoff_app/utils/long_button.dart';
import 'package:gencoff_app/utils/gesture_detector.dart';
import 'package:gencoff_app/utils/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gencoff_app/providers/firebase_provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    if (_isValidEmail(_controllerEmail.text.trim())) {
      try {
        await Firebase().signInWithEmailAndPassword(
            email: _controllerEmail.text.trim(),
            password: _controllerPassword.text.trim());
        _showDialogSucces();
      } on FirebaseAuthException catch (e) {
        switch ('${e.code}') {
          case 'user-disabled':
            _showDialogFail("Akun anda dinonaktifkan oleh administrator");
            break;
          case 'channel-error':
            _showDialogFail("Data tidak boleh kosong!");
            break;
          case 'user-not-found':
            _showDialogFail(
                "Email yang anda masukkan tidak terdaftar sebagai pengguna");
            break;
          case 'too-many-requests':
            _showDialogFail("Terlalu banyak permintaan, coba lagi nanti");
            break;
          case 'network-request-failed':
            _showDialogFail(
                "Terdapat kesalahan dalam jaringan, coba lagi nanti");
            break;
          case 'invalid-credential':
            _showDialogFail("Email dan password yang anda masukan salah");
            break;
          default:
            _showDialogFail('${e.code}: ${e.message}');
        }
      }
    } else {
      _showDialogFail("Pastiksn email valid");
    }
  }

  bool _isValidEmail(String email) {
    // Gunakan ekspresi reguler atau pustaka validasi email untuk memeriksa format email
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _showDialogSucces() {
    showDialog(
      context: context,
      builder: (context) {
        return SuccesAlertState(
          message: "Berhasil Masuk",
          onPressed: () => Navigator.pop(context),
        );
      },
    );
  }

  void _showDialogFail(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return FailAlertState(
          message: message,
          onPressed: () => Navigator.pop(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 80),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Gesture(
                    text: "Lupa password?",
                    onTap: () {
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                  ),
                ],
              ),
              SizedBox(height: 140),
              LongButton(
                text: "Masuk",
                onPressed: _signInWithEmailAndPassword,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun?",
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
