import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/core/constants/error_messages.dart';

import 'package:ofwhich_v2/domain/core/failure/app_failure.dart';
import 'package:path/path.dart';
// import 'package:stacked/stacked_annotations.dart';

import '../../domain/http_service/http_service.dart';
import '../../domain/post/post_service.dart';
import '../core/path.dart';

@LazySingleton(as: PostService)
class IPostRepo implements PostService {
  final IHttpService httpService;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage firebaseStorage;
  IPostRepo(this._firebaseFirestore, this.firebaseStorage, this._firebaseAuth,
      {required this.httpService});
  @override
  Future<Either<AppFailure, String>> createPost(
      {required File file,
      // required String fileame,
      required String locationnId,
      required String comment,
      required List<String> taggedPeople,
      required String fileUrl,
      required String isPublic}) async {
    final filename = basename(file.path);
    var payload = {
      "file_name": filename,
      "file_url": fileUrl,
      // 'upload_file': file.path,
      'location_id': locationnId,
      'comment': comment,
      // 'tagged_people': taggedPeople.isEmpty ? [12] : taggedPeople,
      "is_public": isPublic
    };
    final failureOrSuccessOption = await httpService.postFormDataWithFiles(
        data: file,
        listData: taggedPeople,
        listKey: "tagged_people",
        imageKey: "upload_file",
        path: Paths.createPost,
        payload: payload);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      // UserModel userModel = UserModel.fromMap(r.value["data"]);
      return right("Stufffffffff");
    });
  }

  @override
  Future<Either<AppFailure, String>> uploadFile(
      {required File file,
      String? destination,
      required String locationnId,
      required String comment,
      required List<String> taggedPeople,
      required String isPublic}) async {
    if (file.path != "") {
      final filename = basename(file.path);
      // const destination = 'images/';

      try {
        log(_firebaseAuth.currentUser.toString());
        if (_firebaseAuth.currentUser != null) {
          final ref = firebaseStorage.ref(destination).child("$filename/");
          await ref.putFile(file);
          final link = await ref.getDownloadURL();
          return right(link);
        } else {
          return left(
              AppFailure.unAuthorized(ErrorMessages().unAuthorizedString));
        }
      } catch (e) {
        return left(AppFailure.serverError(e.toString()));
      }
    } else {
      return left(const AppFailure.badRequest("Select an image to upload"));
    }
  }

  @override
  Future<Either<AppFailure, String>> createDraft(
      {required File file,
      required String locationnId,
      required String comment,
      required List<String> taggedPeople,
      required String isPublic,
      required String fileUrl}) async {
    final filename = basename(file.path);
    var payload = {
      "file_name": filename,
      "file_url": fileUrl,
      // 'upload_file': file.path,
      // 'location_id': locationnId,
      'comment': comment,
      // 'tagged_people': taggedPeople.isEmpty ? [12] : taggedPeople,
      // "is_public": isPublic
    };
    final failureOrSuccessOption =
        await httpService.post(path: Paths.createDraft, payload: payload);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      // UserModel userModel = UserModel.fromMap(r.value["data"]);
      return right("Stufffffffff");
    });
  }
}
