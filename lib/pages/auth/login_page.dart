import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/auth_login.dart';
import 'package:gencoff_app/view_model/login_view_model.dart';
import 'package:gencoff_app/widgets/alert.dart';
import 'package:gencoff_app/widgets/long_button.dart';
import 'package:gencoff_app/widgets/gesture_detector.dart';
import 'package:gencoff_app/widgets/input.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
        await LoginViewModel().signInWithEmailAndPassword(
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
            _showDialogFail(
                "Alamat email dan kata sandi yang anda masukan salah");
            break;
          default:
            _showDialogFail('${e.code}: ${e.message}');
        }
      }
    } else {
      _showDialogFail("Pastikan alamat email valid");
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
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const AuthLogin()), // Ganti HomePage dengan halaman yang sesuai
            (Route<dynamic> route) => false,
          ),
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Masuk",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset('assets/images/logo.png', width: 100),
                const SizedBox(
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Alamat email",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InputWithoutIcon(
                      text: "Masukan alamat email",
                      controller: _controllerEmail,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Kata sandi",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InputPassword(
                      text: "Masukan kata sandi",
                      controller: _controllerPassword,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                const SizedBox(height: 120),
                LongButton(
                  text: "Masuk",
                  onPressed: _signInWithEmailAndPassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum punya akun?",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
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
      ),
    );
  }
}
