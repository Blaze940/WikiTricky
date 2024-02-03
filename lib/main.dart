import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_tricky/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:wiki_tricky/src/services/auth_api_service.dart';
import 'package:wiki_tricky/src/views/auth/login_screen.dart';
import 'package:wiki_tricky/src/views/auth/signup_screen.dart';
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
        builder: (context, state) => const SignupScreen(),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthApiService()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        title: 'WikiTricky',
        theme: buildAppTheme(),
      ),
    );
  }
}

