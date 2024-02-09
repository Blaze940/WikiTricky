import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wiki_tricky/src/helpers/validators.dart';

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

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytesConverted = await File(pickedFile.path).readAsBytes();
      setState(() {
        _image = File(pickedFile.path);
        _imageBase64 = base64Encode(imageBytesConverted);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                const Text('Create a Post', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                  validator: validatePostContent,
                ),
                SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.image, color: Color(0xFF8B0000)),
                  label: Text('Choose Image'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF8B0000)),
                  ),
                ),
                if (_image != null)
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 200,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Image.file(_image!),
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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Logique pour traiter le contenu et l'image ici
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8B0000),
            ),
            child: const Text('Post'),
          ),
        ]
    );
  }
}
