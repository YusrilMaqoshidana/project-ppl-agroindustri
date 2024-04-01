import 'package:flutter/material.dart';

class InputWithoutIcon extends StatelessWidget {
  final String text;
  const InputWithoutIcon({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class InputPassword extends StatefulWidget {
  final String text;

  const InputPassword({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _isSecure = true;
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _isSecure,
      decoration: InputDecoration(
        labelText: widget.text,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_isSecure ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _isSecure = !_isSecure;
            });
          },
        ),
      ),
    );
  }
}
