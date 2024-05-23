import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/pages/auth/login_page.dart';
import 'package:gencoff_app/view_model/register_view_model.dart';
import 'package:gencoff_app/widgets/long_button.dart';
import 'package:gencoff_app/widgets/gesture_detector.dart';
import 'package:gencoff_app/widgets/input.dart';
import 'package:gencoff_app/widgets/alert.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_passwordController.text.trim() ==
        _passwordConfirmController.text.trim()) {
      try {
        await RegisterViewModel().createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        RegisterViewModel().addUserDetails(
            username: _userController.text.trim(),
            email: _emailController.text.trim());
        _showDialogSucces();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'invalid-email':
            _showDialogFail("Pastikan format alamat email anda benar");
            break;
          case 'channel-error':
            _showDialogFail("Data tidak boleh kosong!");
            break;
          case 'email-already-in-use':
            _showDialogFail("Alamat email yang anda masukan sudah terdaftar");
            break;
          case 'too-many-requests':
            _showDialogFail("Terlalu banyak permintaan, coba lagi nanti");
            break;
          case 'network-request-failed':
            _showDialogFail(
                "Terdapat kesalahan dalam jaringan, coba lagi nanti");
            break;
          default:
            _showDialogFail('${e.code}: ${e.message}');
        }
      }
    } else if (!usernameValidation(_userController)) {
      _showDialogFail("Pastikan karakter nama tidak terlalu pendek");
    } else {
      _showDialogFail('Pastikan kata sandi cocok');
    }
  }

  bool usernameValidation(TextEditingController username) {
    return _userController.text.length >= 3;
  }

  void _showDialogSucces() {
    showDialog(
      context: context,
      builder: (context) {
        return SuccesAlertState(
          message: "Berhasil Daftar",
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const LoginPage()), // Ganti HomePage dengan halaman yang sesuai
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: const Text(
          "Daftar",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            fontSize: 26,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nama",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InputWithoutIcon(
                    text: "Masukan nama",
                    controller: _userController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Konfirmasi kata sandi",
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
                    controller: _passwordConfirmController,
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              LongButton(
                text: "Daftar",
                onPressed: _signUp,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sudah punya akun?"),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Gesture(
                      text: "Masuk",
                      onTap: () {
                        Navigator.of(context).pop(context);
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
