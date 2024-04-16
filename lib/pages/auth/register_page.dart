import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/providers/firebase_provider.dart';
import 'package:gencoff_app/utils/long_button.dart';
import 'package:gencoff_app/utils/gesture_detector.dart';
import 'package:gencoff_app/utils/input.dart';
import 'package:gencoff_app/utils/alert.dart';

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
        await Firebase().createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        Firebase().addUserDetails(
            username: _userController.text.trim(),
            email: _emailController.text.trim());
        _showDialogSucces();
      } on FirebaseAuthException catch (e) {
        switch ('${e.code}') {
          case 'invalid-email':
            _showDialogFail("Pastikan format email anda benar");
            break;
          case 'channel-error':
            _showDialogFail("Data tidak boleh kosong!");
            break;
          case 'weak-password':
            _showDialogFail("Pastikan password lebih dari 6 karakter");
            break;
          case 'email-already-in-use':
            _showDialogFail("Email yang anda masukan sudah terdaftar");
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
      _showDialogFail("Pastikan karakter username tidak terlalu pendek");
    } else {
      _showDialogFail('Pastikan password cocok');
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
          onPressed: () => Navigator.pushNamed(context, '/login'),
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
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                onPressed: _signUp,
              ),
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
