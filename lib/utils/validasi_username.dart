import 'package:flutter/widgets.dart';

bool usernameValidation(TextEditingController username) {
    return username.text.length >= 3;
  }