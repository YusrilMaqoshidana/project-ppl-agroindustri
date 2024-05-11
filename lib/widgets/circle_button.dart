import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  CircleButton({Key? key, required this.onPress}) : super(key: key);

  final VoidCallback onPress;

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool isOnOff = false;

  void toggleButton() {
    setState(() {
      isOnOff = !isOnOff;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(999),border: Border.all(color: Colors.grey, width: 3)),
            child: ElevatedButton(
                child: Text(
                  isOnOff ? 'ON' : 'OFF', style: TextStyle(fontFamily: "Inter", fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          isOnOff ? Colors.green : Colors.red,),
                    ),
                onPressed: () {
                  toggleButton();
                  widget.onPress;
                }),
      ),
    );
  }
}
