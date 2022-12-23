import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  FirebaseStorageService({
    required this.folder,
  }) {
    _firebaseStorage = FirebaseStorage.instance.ref(folder);
  }

  late Reference _firebaseStorage;

  final String folder;

  Future<String> uploadFile(File path) async {
    try {
      final fileName = DateTime.now().toIso8601String();
      final reference = _firebaseStorage.child(fileName);
      final task = await reference.putFile(path);
      return await task.ref.getDownloadURL();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteImage(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
    } catch (_) {
      rethrow;
    }
  }
}
