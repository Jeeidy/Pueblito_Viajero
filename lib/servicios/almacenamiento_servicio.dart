import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(String userId, dynamic image, String carpeta) async {
    try {
      Reference ref = _storage.ref().child(carpeta).child('$userId.jpg');
      UploadTask uploadTask;
      SettableMetadata metadata;
      if (image is File) {
        metadata = SettableMetadata(contentType: 'image/jpeg');
        uploadTask = ref.putFile(image, metadata);
      } else if (image is Uint8List) {
        metadata = SettableMetadata(contentType: 'image/jpeg');
        uploadTask = ref.putData(image, metadata);
      } else {
        throw Exception('Tipo de imagen no soportado ${image.runtimeType}');
      }
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;

    } catch (e) {
      print('Error al subir imagen: $e');
      return null;
    }
  }

  Future<List<String?>> uploadImages(String docId, List<dynamic> images, String carpeta) async {
    List<String?> downloadUrls = [];

    for (int i = 0; i < images.length; i++) {
      var image = images[i];
      try {
        Reference ref = _storage.ref().child(carpeta).child('${docId}_${i + 1}.jpg');
        UploadTask uploadTask;
        SettableMetadata metadata;
        if (image is File) {
          metadata = SettableMetadata(contentType: 'image/jpeg');
          uploadTask = ref.putFile(image, metadata);
        } else if (image is Uint8List) {
          metadata = SettableMetadata(contentType: 'image/jpeg');
          uploadTask = ref.putData(image, metadata);
        } else {
          throw Exception('Tipo de imagen no soportado ${image.runtimeType}');
        }
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);

      } catch (e) {
        print('Error al subir imagen: $e');
        downloadUrls.add(null);
      }
    }

    return downloadUrls;
  }
}
