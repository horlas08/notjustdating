import 'dart:io';

import 'package:dartz/dartz.dart';

import '../core/failure/app_failure.dart';
// import 'package:smartpay/domain/core/failure/app_failure.dart';

abstract class IHttpService {
  Future<Either<AppFailure, Right>> post(
      {required Map<String, dynamic> payload, required String path});
  Future<Either<AppFailure, Right>> postList(
      {required List payload, required String path});

  Future<Either<AppFailure, Right>> postFormData(
      {required Map<String, String> payload,
      required String path,
      File? file,
      String? imageKey});

  Future<Either<AppFailure, Right>> postFormDataWithFiles(
      {required Map<String, String> payload,
      List<dynamic>? listData,
      String? listKey,
      String? imageKey,
      required String path,
      File? data});
  Future<Either<AppFailure, Right>> getData({required String path});
  Future<Either<AppFailure, Right>> delete({required String path});

  Future<Either<AppFailure, Right>> put(
      {required Map<String, dynamic> payload, required String path});

  Future<Either<AppFailure, Right>> patch(
      {required Map<String, dynamic> payload, required String path});
}
