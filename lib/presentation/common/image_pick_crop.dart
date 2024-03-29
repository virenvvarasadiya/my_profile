import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<XFile?> pickImageFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery,imageQuality: 20);
    if (pickedFile != null) {
      final CroppedFile? croppedFile = await _getCroppedImage(pickedFile);
      if (croppedFile != null) {
        return XFile(croppedFile.path);
      }
    }
    return null;
  }

  static Future<XFile?> captureImageFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final CroppedFile? croppedFile = await _getCroppedImage(pickedFile);
      if (croppedFile != null) {
        return XFile(croppedFile.path);
      }
    }
    return null;
  }

  static Future<CroppedFile?> _getCroppedImage(XFile imageFile) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      return croppedFile;
    } catch (e) {
      debugPrint('Image cropping failed: $e');
      return null;
    }
  }
}