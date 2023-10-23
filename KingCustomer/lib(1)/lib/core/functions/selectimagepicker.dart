import 'dart:io';

import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();
late File imageFile;
Future<File> pickImageFromGallery() async {
  final pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 50,
  );
  if (pickedFile != null) {
    imageFile = File(pickedFile.path);
  }
  return imageFile;
}

Future<File> pickImageFromCamera() async {
  final pickedFile = await picker.pickImage(
    source: ImageSource.camera,
    imageQuality: 50,
    // maxHeight: 200,
    // maxWidth: 200,
  );
  if (pickedFile != null) {
    imageFile = File(pickedFile.path);
  }
  return imageFile;
}
