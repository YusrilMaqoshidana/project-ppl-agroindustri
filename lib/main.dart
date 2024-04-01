import 'package:flutter/material.dart';
import 'package:gencoff_app/pages/auth/forgot_password_page.dart';
import 'package:gencoff_app/pages/auth/login_page.dart';
import 'package:gencoff_app/pages/auth/recovery_password_page.dart';
import 'package:gencoff_app/pages/auth/register_page.dart';

void main() {
  runApp(const Gencoff());
}

class Gencoff extends StatelessWidget {
  const Gencoff({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login':(context) => LoginPage(),
        '/register':(context) => RegisterPage(),
        '/forgot_password':(context) => ForgotPasswordPage(),
        '/recovery_password':(context) => RecoveryPasswordPage(),
      },
      home: LoginPage(),
    );
  }
}
