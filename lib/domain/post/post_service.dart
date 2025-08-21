import 'dart:io';

import 'package:dartz/dartz.dart';

import '../core/failure/app_failure.dart';

abstract class PostService {
  Future<Either<AppFailure, String>> createPost({
    required File file,
    required String locationnId,
    required String comment,
    required List<String> taggedPeople,
    required String isPublic,
    required String fileUrl,
  });

    Future<Either<AppFailure, String>> uploadFile({
    required File file,
    String? destination,
    required String locationnId,
    required String comment,
    required List<String> taggedPeople,
    required String isPublic,
  });

  Future<Either<AppFailure,String>> createDraft({
     required File file,
    required String locationnId,
    required String comment,
    required List<String> taggedPeople,
    required String isPublic,
    required String fileUrl,
  });
}
