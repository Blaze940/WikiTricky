import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 70,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Sign in to your account',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 30,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  //TODO: Implement sign in functionality
                },
                child: const Text('Sign in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
              TextButton(
                child: const Text('Forgot your password?',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
                onPressed: () {
                  //TODO: Implement password forgotten
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
