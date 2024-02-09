import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ImageService {
  static Future<Map<String, dynamic>> pickImageAndEncodeBase64(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      String mimeType = lookupMimeType(pickedFile.path) ?? 'application/octet-stream';
      String base64Prefix = 'data:$mimeType;base64,';
      String base64ImageVanilla = base64Encode(imageBytes);
      return {
        'base64ImageVanilla': base64ImageVanilla,
        'base64Image': base64Prefix + base64ImageVanilla,
        'pickedFile': pickedFile,
      };
    }
    return {'base64ImageVanilla': null, 'base64Image': null, 'pickedFile': null};
  }
}
