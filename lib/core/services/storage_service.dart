import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String _resumesFolder = 'resumes';
  final uid = FirebaseAuth.instance.currentUser!.uid;
  /// Upload a file and return the download URL
  Future<String> uploadResume(File file) async {
    try {
      final fileId = const Uuid().v4(); // unique file name
      //final ref = _storage.ref().child('$_resumesFolder/$fileId-${file.path.split('/').last}');
      final ref = _storage.ref().child('resumes/$uid/$fileId-${file.path.split('/').last}');
      final task = await ref.putFile(file);
      final downloadUrl = await task.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload resume: $e');
    }
  }
}