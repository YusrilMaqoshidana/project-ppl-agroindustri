import 'package:flutter/material.dart';
import 'package:gencoff_app/view_model/realtime_provider.dart';

class CircleButton extends StatefulWidget {
  const CircleButton({super.key});
  static bool kondisi = false;

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool isOnOff = false;

  void toggleButton() {
    setState(() {
      isOnOff = !isOnOff;
      CircleButton.kondisi = isOnOff;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.grey, width: 3)),
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                isOnOff ? Colors.green : Colors.red,
              ),
            ),
            onPressed: () {
              toggleButton();
              RealtimeDatabase().statusTombol(isOnOff);
            },
            child: Text(
              isOnOff ? 'ON' : 'OFF',
              style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            )),
      ),
    );
  }
}
