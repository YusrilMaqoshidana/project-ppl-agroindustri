import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/models/sensor_sata.dart';
import 'package:gencoff_app/pages/auth/login_page.dart';
import 'package:gencoff_app/utils/auth_login.dart';
import 'package:gencoff_app/pages/auth/forgot_password_page.dart';
import 'package:gencoff_app/pages/auth/register_page.dart';
import 'package:gencoff_app/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Gencoff());
}

class Gencoff extends StatelessWidget {
  const Gencoff({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SensorData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/forgot_password': (context) => const ForgotPasswordPage(),
          '/auth_login': (context) => const AuthLogin(),
        },
        home: const SplashScreenPage(),
      ),
    );
  }
}
