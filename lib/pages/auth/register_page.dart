import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/show_dialog.dart';
import 'package:gencoff_app/utils/validasi_username.dart';
import 'package:gencoff_app/view_models/auth/auth_login.dart';
import 'package:gencoff_app/view_models/auth/register_view_model.dart';
import 'package:gencoff_app/widgets/long_button.dart';
import 'package:gencoff_app/widgets/gesture_detector.dart';
import 'package:gencoff_app/widgets/input.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

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
            _passwordConfirmController.text.trim() &&
        usernameValidation(_userController)) {
      try {
        await RegisterViewModel().createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        RegisterViewModel().addUserDetails(
            username: _userController.text.trim(),
            email: _emailController.text.trim());
        // ignore: use_build_context_synchronously
        showDialogSucces(context,message: 'Berhasil membuat akun');
      } on FirebaseAuthException catch (e) {
        switch ('${e.code}') {
          case 'invalid-email':
            // ignore: use_build_context_synchronously
            showDialogFail(context, message: "Pastikan format alamat email anda benar");
            break;
          case 'channel-error':
            // ignore: use_build_context_synchronously
            showDialogFail(context, message: "Data tidak boleh kosong!");
            break;
          case 'email-already-in-use':
            // ignore: use_build_context_synchronously
            showDialogFail(context, message: "Alamat email yang anda masukan sudah terdaftar");
            break;
          case 'too-many-requests':
            // ignore: use_build_context_synchronously
            showDialogFail(context,message: "Terlalu banyak permintaan, coba lagi nanti");
            break;
          case 'network-request-failed':
            // ignore: use_build_context_synchronously
            showDialogFail(context, message: "Terdapat kesalahan dalam jaringan, coba lagi nanti", 
                );
            break;
          default:
            showDialogFail(context, message: '${e.code}: ${e.message}');
        }
      }
    } else if (!usernameValidation(_userController)) {
      showDialogFail(context, message: "Pastikan karakter nama tidak terlalu pendek");
    } else {
      showDialogFail(context, message: 'Pastikan kata sandi cocok');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Daftar",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  letterSpacing: 3,
                ),
              ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const AuthLogin()));
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
