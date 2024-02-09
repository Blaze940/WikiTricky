import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wiki_tricky/src/views/auth/signup_view.dart';

import '../views/auth/login_view.dart';
import '../views/navigation/navigation_view.dart';

navigateToLogin(BuildContext context) {
  GoRouter.of(context).go(LoginView.routeName);
}

navigateToHome(BuildContext context) {
  GoRouter.of(context).go(NavigationView.routeName);
}

navigateToSignup(BuildContext context) {
  GoRouter.of(context).go(SignupView.routeName);
}