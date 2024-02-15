import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../models/comments/comment.dart';

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
                if(canEdit)
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black, size: 20),
                  onPressed: () {
                    // Logic to edit the comment
                  },
                ),
                if(canEdit)
                IconButton(
                  icon: Icon(Icons.delete, color: Color(0xFF8B0000), size: 20),
                  onPressed: () {
                    // Logic to delete the comment
                  },
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
}
