import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            ElevatedButton(
              child: Text("Go to Register"), 
              onPressed: (){
              Navigator.pushNamed(context, '/register');
              },
            ),
            ElevatedButton(
              child: Text("Go to Forgot Password"), 
              onPressed: (){
              Navigator.pushNamed(context, '/forgot_password');
              },
            ),
          ],
        ),
      ),
    );
  }
}
