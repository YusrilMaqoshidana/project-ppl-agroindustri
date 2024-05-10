import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/show_dialog.dart';
import 'package:gencoff_app/utils/validasi_email.dart';
import 'package:gencoff_app/view_models/auth/login_view_model.dart';
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

  Future<void> signInWithEmailAndPassword() async {
    if (isValidEmail(_controllerEmail.text.trim())) {
      try {
        await LoginViewModel().signIn(
            email: _controllerEmail.text.trim(),
            password: _controllerPassword.text.trim());
        // ignore: use_build_context_synchronously
        showDialogSucces(context ,message: 'Berhasil masuk');
      } on FirebaseAuthException catch (e) {
        switch ('${e.code}') {
          case 'user-disabled':
            // ignore: use_build_context_synchronously
            showDialogFail(context,
                message: "Akun anda dinonaktifkan oleh administrator");
            break;
          case 'channel-error':
            // ignore: use_build_context_synchronously
            showDialogFail(context, message: "Data tidak boleh kosong!");
            break;
          case 'user-not-found':
            // ignore: use_build_context_synchronously
            showDialogFail(context,
                message:
                    "Email yang anda masukkan tidak terdaftar sebagai pengguna");
            break;
          case 'too-many-requests':
            // ignore: use_build_context_synchronously
            showDialogFail(context, message: "Terlalu banyak permintaan, coba lagi nanti");
            break;
          case 'network-request-failed':
            // ignore: use_build_context_synchronously
            showDialogFail(context,message: "Terdapat kesalahan dalam jaringan, coba lagi nanti"
                );
            break;
          case 'invalid-credential':
            // ignore: use_build_context_synchronously
            showDialogFail(context, message: "Alamat email dan kata sandi yang anda masukan salah",
                );
            break;
          default:
            showDialogFail(context ,message: '${e.code}: ${e.message}');
        }
      }
    } else {
      showDialogFail(context ,message: "Pastiksn alamat email valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 80),
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
              const SizedBox(height: 100),
              LongButton(
                text: "Masuk",
                onPressed: signInWithEmailAndPassword,
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
    );
  }
}

// routes
// login (1) -> resetPassword -> login(1) 