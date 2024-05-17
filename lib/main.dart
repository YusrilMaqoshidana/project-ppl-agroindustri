import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/pages/auth/login_page.dart';
import 'package:gencoff_app/utils/auth_login.dart';
import 'package:gencoff_app/pages/Homepage/wifi_manager_page.dart';
import 'package:gencoff_app/pages/auth/forgot_password_page.dart';
import 'package:gencoff_app/pages/auth/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Gencoff());
}

class Gencoff extends StatelessWidget {
  const Gencoff({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/wifi_manager': (context)=> const WifiManager(),
        '/auth_login': (context) => const AuthLogin(),
      },
      home: const AuthLogin(),
    );
  }
}
