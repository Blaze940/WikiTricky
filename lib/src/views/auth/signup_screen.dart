import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wiki_tricky/src/helpers/validators.dart';

import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';
  final _formKey = GlobalKey<FormState>();

  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8B0000),
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
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Fill the form below',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildSignUpForm(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
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
                        onPressed: _navigateToLogin(context),
                        child: const Text('Login')),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    void validateForm() {
      if (_formKey.currentState!.validate()) {}
    }

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
              decoration: InputDecoration(
                hintText: 'Username',
                prefixIcon: const Icon(Icons.person, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: validateUsername,
            ),
            const SizedBox(height: 16),
            TextFormField(
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
            ElevatedButton(
              onPressed: validateForm,
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToLogin(BuildContext context) {
    return () {
      GoRouter.of(context).go(LoginScreen.routeName);
    };
  }
}
