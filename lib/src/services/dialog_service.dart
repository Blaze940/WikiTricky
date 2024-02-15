import 'package:flutter/material.dart';

import '../widgets/custom_alert_dialog.dart';

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String message,
  String buttonTextPositive = 'Yes',
  String buttonTextNegative = 'No',
  VoidCallback? onPositivePressed,
  VoidCallback? onNegativePressed,
  IconData? iconData, //
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: title,
        message: message,
        buttonTextPositive: buttonTextPositive,
        buttonTextNegative: buttonTextNegative,
        onPositivePressed: onPositivePressed,
        onNegativePressed: onNegativePressed,
        iconData: iconData,
      );
    },
  );
}
