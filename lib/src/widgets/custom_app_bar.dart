import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:wiki_tricky/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:wiki_tricky/src/services/toast_service.dart';

import '../services/router_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const CustomAppBar({
    Key? key,
    this.titleText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        child: AppBar(
          backgroundColor: const Color(0xFF8B0000),
          elevation: 20,
          leading: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.status == AuthStatus.success
                  ? IconButton(
                      icon:
                          const Icon(Icons.account_circle, color: Colors.white),
                      onPressed: () {
                        // TODO: Navigate to profile
                      },
                    )
                  : const Icon(Icons.no_accounts, color: Colors.grey);
            },
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo_wiki_twiki_white.png', height: 40),
              const SizedBox(width: 2),
              Text(
                titleText,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          blurRadius: 2,
                          offset: Offset(0, 2))
                    ]),
              ),
            ],
          ),
          centerTitle: true,
          actions: <Widget>[
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.status == AuthStatus.success
                    ? IconButton(
                        icon: const Icon(Icons.logout, color: Colors.white),
                        onPressed: () => _showLogoutDialog(context),
                      )
                    : IconButton(
                        icon: const Icon(Icons.login, color: Colors.white),
                        onPressed: () => _showLoginDialog(context),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.logout, color: Color(0xFF8B0000), size: 48),
                const SizedBox(height: 16),
                const Text('Logout',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Text('Do you want to disconnect ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400]),
                      child: const Text('No'),
                    ),
                    ElevatedButton(
                      onPressed: () => disconnectUser(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B0000)),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.login, color: Color(0xFF8B0000), size: 48),
                const SizedBox(height: 16),
                const Text('Connexion',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Text('Moves you to login page. \nContinue ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400]),
                      child: const Text('No'),
                    ),
                    ElevatedButton(
                      onPressed: () => navigateToLogin(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B0000)),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void disconnectUser(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(LogoutRequested());
    Navigator.of(context).pop();
    showCustomToast(context,
        type: ToastificationType.success,
        title: "Disconnected",
        description: "You have been disconnected");
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
