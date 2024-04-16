import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/long_button.dart';

class SuccesAlertState extends StatelessWidget {
  SuccesAlertState({Key? key, required this.message, required this.onPressed})
      : super(key: key);

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Berhasil",
        style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.green),
      ),
      content: SizedBox(
        height: 180,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Image.asset('assets/images/succes.png', width: 80,),
            SizedBox(height: 20,),
            Text(message, style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black),
                textAlign: TextAlign.center
                ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: LongButton(text: 'OK',onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class FailAlertState extends StatelessWidget {
  FailAlertState({Key? key, required this.message, required this.onPressed})
      : super(key: key);

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Gagal",
        style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.red),
      ),
      content: SizedBox(
        height: 180,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Image.asset('assets/images/fail.png', width: 80,),
            SizedBox(height: 20,),
            Text(message, style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black),
                textAlign: TextAlign.center
                ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: LongButton(text: 'OK',onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class ValidationState extends StatelessWidget {
  ValidationState({Key? key, required this.message, required this.onPressed})
      : super(key: key);

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 180,
        child: Column(
        children: [
          SizedBox(height: 20,),
          Image.asset('assets/images/validasi.png', width: 80,),
          SizedBox(height: 20,),
          Text(message, style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w600),
              textAlign: TextAlign.center
              ),
        ],
              ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("No")),
        TextButton(onPressed: onPressed, child: Text("Iya")),
      ],
    );
  }
}
