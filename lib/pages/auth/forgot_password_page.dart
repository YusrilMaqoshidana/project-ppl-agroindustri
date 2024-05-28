import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/pages/auth/login_page.dart';
import 'package:gencoff_app/view_model/forgot_password_view_model.dart';
import 'package:gencoff_app/widgets/alert.dart';
import 'package:gencoff_app/widgets/long_button.dart';
import 'package:gencoff_app/widgets/input.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
  }

  Future<void> _passwordReset() async {
    final email = _controllerEmail.text.trim();
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userDoc.docs.isNotEmpty) {
      try {
        await ForgotPasswordViewModel()
          .forgotPassword(email: email);
      _showDialogSuccess(
          'Link berhasil terkirim, cek alamat email anda!');
      } on FirebaseAuthException catch (e) {
        switch ('${e.code}') {
          case 'channel-error':
            _showDialogFail("Data tidak boleh kosong!");
            break;
          case 'user-not-found':
            _showDialogFail(
                "Email anda tidak terdaftar sebagai pengguna");
            break;
          case 'network-request-failed':
            _showDialogFail(
                "Terdapat kesalahan dalam jaringan, coba lagi nanti");
            break;
          default:
            _showDialogFail('${e.code}: ${e.message}');
        }
      }
    } else {
      _showDialogFail('Alamat email yang anda masukan salah');
    }
  }

  void _showDialogFail(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return FailAlertState(
            message: message, onPressed: () => Navigator.pop(context));
      },
    );
  }

  void _showDialogSuccess(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return SuccesAlertState(
            message: message,
            onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LoginPage()), // Ganti HomePage dengan halaman yang sesuai
                  (Route<dynamic> route) => false,
                ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
                "Lupa Kata Sandi",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Image.asset(
                'assets/images/forgot_password.png',
                width: 250,
              ),
              const SizedBox(
                height: 10,
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
                ],
              ),
              const SizedBox(
                height: 240,
              ),
              LongButton(
                text: "Konfirmasi",
                onPressed: _passwordReset,
              )
            ],
          ),
        ),
      ),
    );
  }
}
