import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:wiki_tricky/src/services/toast_service.dart';

import '../../blocs/posts_bloc/post_bloc.dart';

class DeletePostDialog extends StatefulWidget {
  final String authToken;
  final int post_id;

  const DeletePostDialog({
    Key? key,
    required this.authToken,
    required this.post_id,
  }) : super(key: key);

  @override
  DeletePostDialogState createState() => DeletePostDialogState();
}

class DeletePostDialogState extends State<DeletePostDialog> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: _postBlocListener,
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
                Text('Delete Post',
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Are you sure you want to delete this post?'),
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
            onPressed: _onDeletePostPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B0000),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _postBlocListener(BuildContext context, PostState state) {
    if(state.status == PostStatus.loadingDeletePost) {
      setState(() {
        _isDeleting = true;
      });
    } else if(state.status == PostStatus.successDeletePost) {
      showCustomToast(context,type : ToastificationType.success, title: 'Post deleted ',description: 'Your post has been deleted successfully.');
      Navigator.of(context).pop();
    } else if(state.status == PostStatus.error) {
      showCustomToast(context, type: ToastificationType.error, title: "Error", description: state.error?.toString() ?? "Error while deleting post");
      setState(() {
        _isDeleting = false;
      });
    }
  }
  void _onDeletePostPressed() {
    final postBloc = BlocProvider.of<PostBloc>(context);
    postBloc.add(DeletePost(widget.post_id, widget.authToken));
  }

}
