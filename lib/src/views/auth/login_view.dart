import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:wiki_tricky/src/helpers/validators.dart';
import 'package:wiki_tricky/src/views/auth/signup_view.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../services/toast_service.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/login';

  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        handleAuthState(state);
      },
      child: Scaffold(
        backgroundColor: Color(0xFF8B0000),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const SizedBox(
                    height: 200,
                    child: Image(
                      image: AssetImage('assets/logo_wiki_twiki_white.png'),
                    ),
                  ),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Login to continue',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _buildLoginForm(context),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () => _navigateToSignUp(context),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: validateEmail,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: validatePassword,
            ),
            const SizedBox(height: 24),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.status == AuthStatus.loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => _validateForm(context),
                        child: const Text(
                          'Go',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      );
              },
            ),
            TextButton(
              child: const Text(
                'Forgot your password?',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                // TODO: Implementer la récupération du mot de passe si nécessaire
              },
            ),
          ],
        ),
      ),
    );
  }

  void _validateForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      BlocProvider.of<AuthBloc>(context).add(
        LoginRequested(email, password),
      );
    }
  }

  void _navigateToSignUp(context) {
    GoRouter.of(context).go(SignupView.routeName);
  }

  void handleAuthState(AuthState state) {
    if (state.status == AuthStatus.success) {
      showCustomToast(
        context,
        type: ToastificationType.success,
        title: 'Success',
        description: 'Ready to continue',
        autoCloseDuration: const Duration(seconds: 2),
      );
      Future.delayed(
        const Duration(seconds: 3),
        () => GoRouter.of(context).go('/'),
      );
    }
    if (state.status == AuthStatus.error) {
      showCustomToast(
        context,
        type: ToastificationType.error,
        title: 'Failed to sign up',
        description: state.error.toString(),
        autoCloseDuration: const Duration(seconds: 6),
      );
    }
  }
}
