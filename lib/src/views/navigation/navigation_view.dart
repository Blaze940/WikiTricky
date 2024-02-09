import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiki_tricky/src/services/secure_storage_service.dart';
import 'package:wiki_tricky/src/widgets/create_post_widget.dart';
import 'package:wiki_tricky/src/widgets/custom_app_bar.dart';
import 'package:wiki_tricky/src/widgets/custom_nav_bar.dart';

import '../../blocs/auth_bloc/auth_bloc.dart'; // Assurez-vous que le nom est correctement orthographié
import '../../services/dialog_service.dart';
import '../../widgets/create_post_dialog.dart';
import '../auth/login_view.dart';
import '../post/community_post_list_view.dart';

class NavigationView extends StatelessWidget {
  static const String routeName = '/';

  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          titleText: 'WikiTwiki',
        ),
        body: CommunityPostListView(),
        bottomNavigationBar: CustomBottomNavBar(),
        floatingActionButton: CreatePostWidget(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => _onCreatePostPressed(context),
        //   backgroundColor: const Color(0xFF8B0000),
        //   child: const Icon(Icons.edit_note, color: Colors.white),
        // ),
      ),
    );
  }

  void _onCreatePostPressed(BuildContext context) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (authBloc.state.status == AuthStatus.success) {
      try {
        final authToken = await SecureStorageService.instance.getAuthToken();
        authToken != null
            ? _showCreatePostDialog(context, authToken)
            : showAuthTokenExpiredDialog(context);
      } catch (e) {
        showAuthTokenExpiredDialog(context);
      }
    } else {
      showYouNeedToBeLoggedInDialog(context);
    }
  }

  void _showCreatePostDialog(BuildContext context, String authToken) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreatePostDialog(authToken: authToken);
      },
    );
  }

  void _navigateToLogin(BuildContext context) {
    GoRouter.of(context).go(LoginView.routeName);
  }

  void showAuthTokenExpiredDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: 'Session expired',
      message: 'Your session has expired. Please log in again.',
      buttonTextPositive: 'Log In',
      buttonTextNegative: 'Cancel',
      onPositivePressed: () {
        _navigateToLogin(context);
      },
      onNegativePressed: () {
        Navigator.of(context).pop();
      },
      iconData: Icons.warning, //
    );
  }

  void showYouNeedToBeLoggedInDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: 'Oops ...',
      message: 'You need to be logged in first to create a post.',
      buttonTextPositive: 'Log In',
      buttonTextNegative: 'Cancel',
      onPositivePressed: () {
        _navigateToLogin(context);
      },
      onNegativePressed: () {
        Navigator.of(context).pop();
      },
      iconData: Icons.login, //
    );
  }
}
