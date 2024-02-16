import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../blocs/comment_bloc/comment_bloc.dart';
import '../../models/comments/comment_update_request.dart';
import '../../services/toast_service.dart';

class UpdateCommentDialog extends StatefulWidget {
  final String authToken;
  final int comment_id;
  final String content;

  const UpdateCommentDialog({
    Key? key,
    required this.authToken,
    required this.comment_id,
    required this.content,
  }) : super(key: key);

  @override
  UpdateCommentDialogState createState() => UpdateCommentDialogState();
}

class UpdateCommentDialogState extends State<UpdateCommentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  bool _isPostingUpdate = false;

  @override
  void initState() {
    super.initState();
    _contentController.text = widget.content;
  }

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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Content is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _isPostingUpdate
                      ? const CupertinoActivityIndicator()
                      : ElevatedButton(
                          onPressed: _updateComment,
                          child: const Text('Update'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateComment() {
    if (_formKey.currentState!.validate()) {
      final commentBlock = BlocProvider.of<CommentBloc>(context);
      final commentUpdateRequest = CommentUpdateRequest(
        content: _contentController.text,
        comment_id: widget.comment_id,
      );
      commentBlock.add(UpdateComment(commentUpdateRequest, widget.authToken));
    }
  }

  void _commentBlocListener(BuildContext context, CommentState state) {
    if(state.status == CommentStatus.loadingUpdateComment){
      setState(() {
        _isPostingUpdate = true;
      });
    } else if(state.status == CommentStatus.successUpdateComment){
      showCustomToast(context, type: ToastificationType.success,
          title: 'Comment updated',
          description: 'Your comment has been updated successfully.');
      Navigator.of(context).pop();
    } else if(state.status == CommentStatus.error){
      showCustomToast(context, type: ToastificationType.error,
          title: "Error",
          description: state.error?.toString() ?? "Error while updating comment");
      setState(() {
        _isPostingUpdate = false;
      });

    }
  }
}