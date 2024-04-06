import 'package:flutter/material.dart';
import 'package:gencoff_app/providers/auth_provider.dart';
import 'package:gencoff_app/utils/long_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget _title(){
    return Text("Settings");
  }
  
  Future<void> signOut() async {
    await Auth().signOut();
  }
  Widget _signOutButton() {
    return LongButton(text: "Sign Out", onPressed: signOut);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:_title(),),
      body: Center(
        child: Column(
          children: [
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
