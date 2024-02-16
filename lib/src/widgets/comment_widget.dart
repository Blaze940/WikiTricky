import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:wiki_tricky/src/widgets/use_cases_dialog/delete_comment_dialog.dart';
import 'package:wiki_tricky/src/widgets/use_cases_dialog/update_comment_dialog.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../models/comments/comment.dart';
import '../services/dialog_service.dart';
import '../services/router_service.dart';
import '../services/secure_storage_service.dart';
import '../services/toast_service.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final isLoggedIn = authBloc.state.status == AuthStatus.success;
    final currentUser = authBloc.state.user;
    final canEdit = isLoggedIn && currentUser?.id == comment.author.id;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(child: Text(comment.author.name[0].toUpperCase())),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    comment.author.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (canEdit)
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.black, size: 20),
                    onPressed: () => _onEditCommentPressed(context),
                  ),
                if (canEdit)
                  IconButton(
                    icon:
                        Icon(Icons.delete, color: Color(0xFF8B0000), size: 20),
                    onPressed: () => _onDeleteCommentPressed(context),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48.0),
              child: Text(
                comment.content,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48.0),
              child: Text(
                'Posted on ${DateFormat('dd/MM/yyyy at HH:mm').format(DateTime.fromMillisecondsSinceEpoch(comment.createdAt))}',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onEditCommentPressed(BuildContext context) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (authBloc.state.status == AuthStatus.success) {
      try {
        final authToken = await SecureStorageService.instance.getAuthToken();
        authToken != null
            ? _showUpdateCommentDialog(context, authToken)
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
        showCustomToast(context,
            type: ToastificationType.error,
            title: 'Session error',
            description: 'An error occurred. Please try again later.');
      }
    } else {
      showCustomDialog(
        context: context,
        title: 'No Session Found',
        message: 'You need to be logged in first to update a comment.',
        buttonTextPositive: 'Log In',
        buttonTextNegative: 'No thanks',
        onPositivePressed: () => navigateToLogin(context),
        onNegativePressed: () => Navigator.of(context).pop(),
      );
    }
  }

  _onDeleteCommentPressed(BuildContext context) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (authBloc.state.status == AuthStatus.success) {
      try {
        final authToken = await SecureStorageService.instance.getAuthToken();
        authToken != null
            ? _showDeleteCommentDialog(context, authToken)
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
        showCustomToast(context,
            type: ToastificationType.error,
            title: 'Session error',
            description: 'An error occurred. Please try again later.');
      }
    } else {
      showCustomDialog(
        context: context,
        title: 'No Session Found',
        message: 'You need to be logged in first to delete a comment.',
        buttonTextPositive: 'Log In',
        buttonTextNegative: 'No thanks',
        onPositivePressed: () => navigateToLogin(context),
        onNegativePressed: () => Navigator.of(context).pop(),
      );
    }
  }

  void _showUpdateCommentDialog(BuildContext context, String authToken) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateCommentDialog(
            comment_id: comment.id,
            authToken: authToken,
            content: comment.content,
          );
        });
  }

  void _showDeleteCommentDialog(BuildContext context, String authToken){
    showDialog(
      context: context,
      builder : (BuildContext context){
        return DeleteCommentDialog(
          comment_id: comment.id,
          authToken: authToken,
        );
      }
    );
  }

}
