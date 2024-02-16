
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:wiki_tricky/src/blocs/comment_bloc/comment_bloc.dart';
import 'package:wiki_tricky/src/services/toast_service.dart';

import '../../models/comments/comment_create_request.dart';

class CreateCommentDialog extends StatefulWidget {
  final String authToken;
  final int post_id;

  const CreateCommentDialog({Key? key, required this.authToken, required this.post_id});

  @override
  CreateCommentDialogState createState() => CreateCommentDialogState();
}

class CreateCommentDialogState extends State<CreateCommentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  bool _isPosting = false;

  @override
  Widget build(BuildContext context){
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _isPosting
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () => _onCreateCommentPressed(context),
                    child: const Text('Comment'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _commentBlocListener(BuildContext context, CommentState state) {
    if(state.status == CommentStatus.loadingCreateComment){
      setState(() {
        _isPosting = true;
      });
    }else if (state.status == CommentStatus.successCreateComment){
      showCustomToast(context, type: ToastificationType.success, title: "Success", description: "Post created successfully");
      setState(() {
        _isPosting = false;
      });
      Navigator.of(context).pop();
    }else if (state.status == CommentStatus.error){
      showCustomToast(context, type: ToastificationType.error, title: "Error", description: state.error?.toString() ?? "Error while creating comment");
      setState(() {
        _isPosting = false;
      });
    }
  }

  _onCreateCommentPressed(BuildContext context) {
    if(_formKey.currentState!.validate()){
      final commentBloc = BlocProvider.of<CommentBloc>(context);
      final commentCreateRequest = CommentCreateRequest(
        content: _contentController.text,
        post_id: widget.post_id,
      );
      commentBloc.add(CreateComment(commentCreateRequest, widget.authToken));
    }
  }

}