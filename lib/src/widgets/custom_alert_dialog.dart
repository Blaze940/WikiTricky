import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonTextPositive;
  final String buttonTextNegative;
  final VoidCallback? onPositivePressed;
  final VoidCallback? onNegativePressed;
  final IconData? iconData;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.buttonTextPositive,
    required this.buttonTextNegative,
    this.onPositivePressed,
    this.onNegativePressed,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = [
      if (iconData != null) Icon(iconData, color: Color(0xFF8B0000), size: 48),
      SizedBox(height: 16),
      Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      SizedBox(height: 16),
      Text(message,
          textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
      SizedBox(height: 24),
    ];

    columnChildren.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (buttonTextNegative.isNotEmpty)
          ElevatedButton(
            onPressed: onNegativePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[400],
            ),
            child: Text(buttonTextNegative),
          ),
        if (buttonTextPositive.isNotEmpty)
          ElevatedButton(
            onPressed: onPositivePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8B0000),
            ),
            child: Text(buttonTextPositive),
          ),
      ],
    ));

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: columnChildren,
        ),
      ),
    );
  }
}
