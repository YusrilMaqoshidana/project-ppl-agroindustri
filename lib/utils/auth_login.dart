import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/bottom_navigasi.dart';
import 'package:gencoff_app/pages/auth/login_page.dart';
import 'package:gencoff_app/view_model/firebase_provider.dart';

class AuthLogin extends StatelessWidget {
  const AuthLogin({Key? key}) : super(key: key); // Perbaikan pada konstruktor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: Firebase().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tampilkan indikator loading jika stream sedang menunggu
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            // Jika ada pengguna yang masuk, tampilkan FirstPage
            return BottomNavigasi();
          } else {
            // Jika tidak ada pengguna yang masuk, tampilkan LoginPage
            return LoginPage();
          }
        },
      ),
    );
  }
}
