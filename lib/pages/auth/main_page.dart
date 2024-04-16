import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/pages/Homepage/first_page.dart';
import 'package:gencoff_app/pages/auth/login_page.dart';
import 'package:gencoff_app/providers/firebase_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key); // Perbaikan pada konstruktor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: Firebase().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tampilkan indikator loading jika stream sedang menunggu
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            // Jika ada pengguna yang masuk, tampilkan FirstPage
            return FirstPage();
          } else {
            // Jika tidak ada pengguna yang masuk, tampilkan LoginPage
            return LoginPage();
          }
        },
      ),
    );
  }
}
