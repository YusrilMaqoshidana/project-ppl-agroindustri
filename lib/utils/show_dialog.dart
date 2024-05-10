import 'package:flutter/material.dart';
import 'package:gencoff_app/widgets/alert.dart';

void showDialogSucces(BuildContext context, {required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return SuccesAlertState(
        message: message,
        onPressed: () => Navigator.pop(context),
      );
    },
  );
}

void showDialogFail(BuildContext context, {required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return FailAlertState(
        message: message,
        onPressed: () => Navigator.pop(context),
      );
    },
  );
}
