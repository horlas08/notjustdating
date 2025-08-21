import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ofwhich_v2/injectable.dart';

mixin StorageService {
  final FirebaseFirestore _firebaseFirestore = getIt<FirebaseFirestore>();
  final FirebaseStorage firebaseStorage = getIt<FirebaseStorage>();

  // Method to get the download URL for a file
  Future<String?> getDownloadURL(String filePath) async {
    try {
      String downloadURL = await firebaseStorage.ref(filePath).getDownloadURL();
      return downloadURL;
    } catch (e) {
      log('Error getting download URL: $e');
      return null;
    }
  }
}
