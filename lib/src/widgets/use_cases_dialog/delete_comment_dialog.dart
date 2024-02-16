import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:wiki_tricky/src/blocs/comment_bloc/comment_bloc.dart';

import '../../services/toast_service.dart';

class DeleteCommentDialog extends StatefulWidget {
  final String authToken;
  final int comment_id;

  const DeleteCommentDialog({
    Key? key,
    required this.comment_id,
    required this.authToken,
  }) : super(key: key);

  @override
  DeleteCommentDialogState createState() => DeleteCommentDialogState();
}

class DeleteCommentDialogState extends State<DeleteCommentDialog> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: _commentBlocListener,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.delete, color: Color(0xFF8B0000), size: 48),
                SizedBox(height: 16),
                Text('Delete Comment',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Are you sure you want to delete this comment?'),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[400],
            ),
            child: const Text('Cancel'),
          ),
          _isDeleting
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: 24,
                  height: 24,
                  child: const CircularProgressIndicator(strokeWidth: 2.0),
                )
              : ElevatedButton(
                  onPressed: () => _deleteComment(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B0000),
                  ),
                  child: const Text('Delete'),
                ),
        ],
      ),
    );
  }

  void _commentBlocListener(BuildContext context, CommentState state) {
    if (state.status == CommentStatus.loadingDeleteComment) {
      setState(() {
        _isDeleting = true;
      });
    } else if (state.status == CommentStatus.successDeleteComment) {
      showCustomToast(context,
          type: ToastificationType.success,
          title: 'Comment deleted ',
          description: 'Your comment has been deleted successfully.');
      Navigator.of(context).pop();
    } else if (state.status == CommentStatus.error) {
      showCustomToast(context,
          type: ToastificationType.error,
          title: "Error",
          description:
              state.error?.toString() ?? "Error while deleting comment");
      setState(() {
        _isDeleting = false;
      });
    }
  }

  void _deleteComment(BuildContext context) {
    final commentBlock = BlocProvider.of<CommentBloc>(context);
    commentBlock.add(DeleteComment(widget.comment_id, widget.authToken));
  }
}
