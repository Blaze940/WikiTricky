import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_tricky/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:wiki_tricky/src/blocs/posts_bloc/post_bloc.dart';
import 'package:wiki_tricky/src/services/api_call/auth_api_service.dart';
import 'package:wiki_tricky/src/services/api_call/post_api_service.dart';
import 'package:wiki_tricky/src/services/secure_storage_service.dart';
import 'package:wiki_tricky/src/views/auth/login_view.dart';
import 'package:wiki_tricky/src/views/auth/signup_view.dart';
import 'package:wiki_tricky/src/views/navigation/navigation_view.dart';
import 'config/app_theme.dart';
import 'package:go_router/go_router.dart';

void main() {
  final goRouter = GoRouter(
    routes:
    [
      GoRoute(
        path: '/',
        builder: (context, state) => const NavigationView(),
      ),
      GoRoute(
        path: LoginView.routeName,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: SignupView.routeName,
        builder: (context, state) =>  const SignupView(),
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
          create: (context) => AuthBloc(AuthApiService(),SecureStorageService()),
        ),
        BlocProvider<PostBloc>(
            create: (context) => PostBloc(PostApiService(),SecureStorageService())
        )
      ],
      child: MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        title: 'WikiTwiki',
        theme: buildAppTheme(),
      ),
    );
  }
}

