import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/alert.dart';
import 'package:gencoff_app/utils/long_button.dart';
import 'package:gencoff_app/utils/input.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

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
        .collection('users') // Replace 'users' with your collection name
        .where('email', isEqualTo: email) // Use email as document ID
        .get();

    if (!userDoc.docs.isEmpty) {
      
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _controllerEmail.text.trim());
        _showDialogSuccess('Link reset password berhasil terkirim, cek email anda!');
    } else {
      _showDialogFail('Pastikan email anda valid');
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
        return SuccesAlertState(message: message, onPressed: () => Navigator.pushNamed(context, '/login'));
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
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
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
              SizedBox(
                height: 10,
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
                    text: "Masukan Email",
                    controller: _controllerEmail,
                  ),
                ],
              ),
              SizedBox(
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
