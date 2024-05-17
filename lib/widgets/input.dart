import 'package:flutter/material.dart';

class InputWithoutIcon extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const InputWithoutIcon({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class InputPassword extends StatefulWidget {
  final String text;
  final TextEditingController controller;

  const InputPassword({
    super.key,
    required this.text,required this.controller
  });

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _isSecure = true;
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isSecure,
      decoration: InputDecoration(
        labelText: widget.text,
        border: const OutlineInputBorder(),
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
