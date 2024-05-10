import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/view_models/auth/auth_login.dart';
import 'package:gencoff_app/widgets/alert.dart';
import 'package:gencoff_app/widgets/long_button.dart';
import 'package:gencoff_app/widgets/input.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // untuk menyimpan email
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  void dispose() {
    // ketika pindah page maka input kembali kosong
    _controllerEmail.dispose();
    super.dispose();
  }

  Future<void> _passwordReset() async {
    final email = _controllerEmail.text.trim();
    // get email yang ada di firestore
    final userDoc = await FirebaseFirestore.instance
        .collection('users') 
        .where('email', isEqualTo: email) // Use email as document ID
        .get();
    
    if (userDoc.docs.isEmpty) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _controllerEmail.text.trim());
        _showDialogSuccess('Link reset kata sandi berhasil terkirim, cek alamat email anda!');
    } else {
      _showDialogFail('Pastikan alamat email anda valid');
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
        return SuccesAlertState(message: message, onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const AuthLogin())));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Lupa Password",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  letterSpacing: 3,
                ),
              ),
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
                height: 200,
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
