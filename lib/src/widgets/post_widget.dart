import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:wiki_tricky/src/views/post/post_detail_view.dart';
import 'package:wiki_tricky/src/views/post/random_user_post_list_view.dart';
import 'package:wiki_tricky/src/widgets/use_cases_dialog/delete_post_dialog.dart';
import 'package:wiki_tricky/src/widgets/use_cases_dialog/update_post_dialog.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../models/items/item.dart';
import '../services/dialog_service.dart';
import '../services/router_service.dart';
import '../services/secure_storage_service.dart';
import '../services/toast_service.dart';

class PostWidget extends StatelessWidget {
  final Item item;

  const PostWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final isLoggedIn = authBloc.state.status == AuthStatus.success;
    final currentUser = authBloc.state.user;
    final canEdit = isLoggedIn && currentUser?.id == item.author.id;

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (item.image != null)
              Image.network(
                item.image!.url,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style : TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () => _onShowAllUserPostPressed(context, item.author.id, item.author.name, item.createdAt),
                        child: Text(
                          item.author.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat('dd MMM yyyy, HH:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  item.createdAt),
                            ),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          if (canEdit)
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Color(0xFF8B0000), size: 20),
                              onPressed: () => _onDeletePostPressed(context),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.content,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.comment,
                              color: Theme.of(context).primaryColor, size: 20),
                          const SizedBox(width: 4),
                          TextButton(
                            onPressed: () => item.commentsCount > 0
                                ? _onShowPostDetailsPressed(context, item.id)
                                : null,
                            style: TextButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              '${item.commentsCount} Comments',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (canEdit)
                            ElevatedButton.icon(
                                icon: const Icon(Icons.edit,
                                    size: 16, color: Color(0xFF8B0000)),
                                label: const Text('Edit',
                                    style: TextStyle(fontSize: 12)),
                                onPressed: () => _onUpdatePostPressed(context),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xFF8B0000),
                                  backgroundColor: Colors.white,
                                )),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.visibility, size: 16),
                            label: const Text('Details',
                                style: TextStyle(fontSize: 12)),
                            onPressed: () =>
                                _onShowPostDetailsPressed(context, item.id),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF8B0000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onUpdatePostPressed(BuildContext context) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (authBloc.state.status == AuthStatus.success) {
      try {
        final authToken = await SecureStorageService.instance.getAuthToken();
        authToken != null
            ? _showUpdatePostDialog(context, authToken)
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
        message: 'You need to be logged in first to update a post.',
        buttonTextPositive: 'Log In',
        buttonTextNegative: 'No thanks',
        onPositivePressed: () => navigateToLogin(context),
        onNegativePressed: () => Navigator.of(context).pop(),
      );
    }
  }

  _onDeletePostPressed(BuildContext context) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (authBloc.state.status == AuthStatus.success) {
      try {
        final authToken = await SecureStorageService.instance.getAuthToken();
        authToken != null
            ? _showDeletePostDialog(context, authToken)
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
        message: 'You need to be logged in first to update a post.',
        buttonTextPositive: 'Log In',
        buttonTextNegative: 'No thanks',
        onPositivePressed: () => navigateToLogin(context),
        onNegativePressed: () => Navigator.of(context).pop(),
      );
    }
  }

  _onShowPostDetailsPressed(BuildContext context, int post_id) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PostDetailView(id: post_id)));
  }

  _onShowAllUserPostPressed(BuildContext context, int user_id, String name, int created_at) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => RandomUserPostListView(user_id: user_id, name: name, created_at: created_at)));
  }

  _showUpdatePostDialog(BuildContext context, String authToken) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdatePostDialog(
            authToken: authToken, post_id: item.id, content: item.content);
      },
    );
  }

  _showDeletePostDialog(BuildContext context, String authToken) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeletePostDialog(authToken: authToken, post_id: item.id);
        });
  }
}
