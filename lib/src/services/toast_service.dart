import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

showCustomToast(BuildContext context, {
  required ToastificationType type,
  required String title,
  required String description,
  Duration? autoCloseDuration,
}) {
  toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.fillColored,
    title: Text(title),
    description: Text(description),
    autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 4),
    alignment: Alignment.topRight,
    // Autres paramètres par défaut
  );
}