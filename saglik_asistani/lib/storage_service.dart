import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageService() {}

  Future<String?> uploadImageToChat(
      {required File file, required String chatID}) async {
    Reference fileref = _firebaseStorage
        .ref('chats/$chatID')
        .child('${DateTime.now().toIso8601String()}${p.extension(file.path)}');
    UploadTask task = fileref.putFile(file);
    return task.then((p) {
      if (p.state == TaskState.success) {
        return fileref.getDownloadURL();
      }
    });
  }
}
