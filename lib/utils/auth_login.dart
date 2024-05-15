import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/bottom_navigasi.dart';
import 'package:gencoff_app/pages/auth/login_page.dart';

class AuthLogin extends StatelessWidget {
  const AuthLogin({Key? key}) : super(key: key); // Perbaikan pada konstruktor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            
            return BottomNavigasi();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
