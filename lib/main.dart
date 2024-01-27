import 'package:flutter/material.dart';
import 'package:huit_heures/src/views/auth/login_screen.dart';
import 'package:huit_heures/src/views/auth/signup_screen.dart';
import 'config/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WikiTricky',
      theme: buildAppTheme(),
      home: LoginScreen(),
      //home: SignupScreen(),
    );
  }
}

