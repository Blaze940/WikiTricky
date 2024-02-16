import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wiki_tricky/src/models/items/post_create_request.dart';
import 'package:toastification/toastification.dart';
import '../../blocs/posts_bloc/post_bloc.dart';
import '../../services/image_service.dart';
import '../../services/toast_service.dart';

class CreatePostDialog extends StatefulWidget {
  final String authToken;

  const CreatePostDialog({Key? key, required this.authToken}) : super(key: key);

  @override
  CreatePostDialogState createState() => CreatePostDialogState();
}

class CreatePostDialogState extends State<CreatePostDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  File? _image;
  String? _imageBase64;
  String? _imageBase64Vanilla ;
  bool _isPosting = false;

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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.edit, color: Color(0xFF8B0000), size: 48),
                  const SizedBox(height: 16),
                  const Text('Create a Post',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _contentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "What's on your mind?",
                      labelText: 'Your Post',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter some text' : null,
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image, color: Color(0xFF8B0000)),
                    label: const Text('Choose Image'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF8B0000)),
                    ),
                  ),
                  if (_imageBase64Vanilla != null)
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 200,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: kIsWeb ? Image.memory(base64Decode(_imageBase64Vanilla!)) : (_image != null ? Image.file(_image!) : const SizedBox()),
                    ),
                ],
              ),
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
          _isPosting
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: 24,
                  height: 24,
                  child: const CircularProgressIndicator(strokeWidth: 2.0),
                )
              : ElevatedButton(
                  onPressed: _onCreatePostPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B0000),
                  ),
                  child: const Text('Post'),
                ),
        ],
      ),
    );
  }

  void _postBlocListener(BuildContext context, PostState state) {
    if (state.status == PostStatus.loadingCreatePost) {
      setState(() => _isPosting = true);
    } else if (state.status == PostStatus.successCreatePost) {
      showCustomToast(context,
          type: ToastificationType.success,
          title: "Success",
          description: "Post created successfully!");
      setState(() => _isPosting = false);
      Navigator.of(context).pop();
    } else if (state.status == PostStatus.error) {
      showCustomToast(context,
          type: ToastificationType.error,
          title: "Error",
          description: state.error?.toString() ?? "Error while creating post");
      setState(() => _isPosting = false);
    }
  }

  void _onCreatePostPressed() {
    if (_formKey.currentState!.validate()) {
      final postBloc = BlocProvider.of<PostBloc>(context);
      final postCreateRequest = PostCreateRequest(
        content: _contentController.text,
        base_64_image: _imageBase64,
      );
      postBloc.add(CreatePost(postCreateRequest, widget.authToken));
    }
  }

  Future<void> _pickImage() async {
    Map base64Image =
        await ImageService.pickImageAndEncodeBase64(ImageSource.gallery);
    if(base64Image['base64ImageVanilla'] != null) {
      setState(() {
        _imageBase64 = base64Image['base64Image'];
        _imageBase64Vanilla = base64Image['base64ImageVanilla'];
        _image = File(base64Image['pickedFile'].path);
      });
    }
  }
}
