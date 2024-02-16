

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:wiki_tricky/src/widgets/use_cases_dialog/create_comment_dialog.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../services/dialog_service.dart';
import '../services/router_service.dart';
import '../services/secure_storage_service.dart';
import '../services/toast_service.dart';

class CreateCommentWidget extends StatelessWidget {
  final int post_id;
  const CreateCommentWidget({Key? key, required this.post_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      onPressed: () => _onPressed(context),
      backgroundColor: const Color(0xFF8B0000),
      child: const Icon(Icons.add_comment, color: Colors.white, size: 24),
    );
  }

  void _onPressed(BuildContext context) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (authBloc.state.status == AuthStatus.success) {
      try {
        final authToken = await SecureStorageService.instance.getAuthToken();
        authToken != null
            ?
        _showCreatePostDialog(context, authToken)
            : showCustomDialog(
          context: context,
          title: 'Session Expired',
          message: 'Your session has expired. Please log in again.',
          buttonTextPositive: 'Go',
          buttonTextNegative: 'Later',
          onPositivePressed: () => navigateToLogin(context),
          onNegativePressed: () => Navigator.of(context).pop(),
        );
      } catch (e) {
        showCustomToast(context, type: ToastificationType.error, title: 'Session error', description: 'An error occurred. Please try again later.');
      }
    } else {
      showCustomDialog(
        context: context,
        title: 'No Session Found',
        message: 'You need to be logged in first to comment.',
        buttonTextPositive: 'Log In',
        buttonTextNegative: 'No thanks',
        onPositivePressed: () => navigateToLogin(context),
        onNegativePressed: () => Navigator.of(context).pop(),
      );
    }
  }

  void _showCreatePostDialog(BuildContext context, String authToken) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateCommentDialog(authToken: authToken, post_id: post_id);
      },
    );
  }


}