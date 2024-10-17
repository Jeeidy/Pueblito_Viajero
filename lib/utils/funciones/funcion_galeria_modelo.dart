import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;

class ImagePickerService {
  Future<void> pickImageFromGallery(dynamic model) async {
    if (kIsWeb) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        model.image = await pickedFile.readAsBytes();
      }
    } else if (Platform.isAndroid && await _isAndroid13OrAbove()) {
      final galleryStatus = await Permission.photos.request();
      if (galleryStatus.isGranted) {
        await _getImageFromGallery(model);
      } else {
        print('Permiso de galería no concedido.');
      }
    } else {
      final storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) {
        await _getImageFromGallery(model);
      } else {
        print('Permiso de almacenamiento no concedido.');
      }
    }
  }

  Future<void> _getImageFromGallery(dynamic model) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      if (pickedFile.path.endsWith('.jpg') || pickedFile.path.endsWith('.jpeg')) {
        model.image = imageFile;
      } else {
        // Convert to JPG
        final image = img.decodeImage(imageFile.readAsBytesSync());
        final jpg = img.encodeJpg(image!);
        final jpgFile = File('${pickedFile.path}.jpg')..writeAsBytesSync(jpg);
        model.image = jpgFile;
      }
    }
  }

  Future<bool> _isAndroid13OrAbove() async {
    final version = await Permission.photos.status;
    return version.isGranted;
  }
}