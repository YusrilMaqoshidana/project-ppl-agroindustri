import 'package:firebase_core/firebase_core.dart';
import 'package:gencoff_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/pages/auth/main_page.dart';
import 'package:gencoff_app/pages/Homepage/wifi_manager_page.dart';
import 'package:gencoff_app/pages/auth/forgot_password_page.dart';
import 'package:gencoff_app/pages/auth/recovery_password_page.dart';
import 'package:gencoff_app/pages/auth/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Gencoff());
}

class Gencoff extends StatelessWidget {
  const Gencoff({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/main_page': (context) => MainPage(),
        '/register': (context) => RegisterPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/recovery_password': (context) => RecoveryPasswordPage(),
        '/wifi_manager': (context)=> WifiManager()
      },
      home: MainPage(),
    );
  }
}
