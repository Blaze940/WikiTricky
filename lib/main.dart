import 'package:flutter/material.dart';
import 'package:huit_heures/src/views/auth/login_screen.dart';
import 'package:huit_heures/src/views/auth/signup_screen.dart';
import 'config/app_theme.dart';
import 'package:go_router/go_router.dart';

void main() {
  final goRouter = GoRouter(
    routes: [
      GoRoute(
          path: '/',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: LoginScreen.routeName,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: SignupScreen.routeName,
        builder: (context, state) =>  SignupScreen(),
      ),
    ],
  );

  runApp(MyApp(goRouter: goRouter));
}

class MyApp extends StatelessWidget {
  final GoRouter goRouter;

  const MyApp({super.key, required this.goRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      title: 'WikiTricky',
      theme: buildAppTheme(),
    );
  }
}
