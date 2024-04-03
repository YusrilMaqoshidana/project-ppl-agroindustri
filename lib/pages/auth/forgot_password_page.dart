import 'package:flutter/material.dart';
import 'package:gencoff_app/widgets/button.dart';
import 'package:gencoff_app/widgets/input.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(25),
          child: Column(
            children: [
              Text(
                  "Lupa Password",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    letterSpacing: 3,
                  ),),
              Image.asset('../../../assets/images/forgot_password.png', width: 300,),
              SizedBox(height: 200,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email"),
                  SizedBox(height: 5,),
                  InputWithoutIcon(text: "Masukan Email"),
                ],
              ),
              SizedBox(height: 40,),
              Button(text: "Konfirmasi", onPressed: (){})
            ],
          ),
        ),
      ),
    );
  }
}
