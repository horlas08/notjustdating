import 'dart:developer';

import 'package:dartz/dartz.dart';
// import 'package:smartpay/domain/core/failure/app_failure.dart';

// import '../../domain/core/constants/error_messages.dart';
import '../../domain/core/failure/app_failure.dart';

Either<AppFailure, Right> handleResponse(
    {required dynamic body, required int statusCode}) {
  int status = body["status"];

  var errors = body["error"];
  String errorMessage;

  if (errors != null && errors.isNotEmpty) {
    errorMessage = errors.toString(); // Use errors as-is
  } else {
    errorMessage = body['message'] ?? 'Unknown error occurred';
  }
  switch (statusCode) {
    case 200:
      if (status == 200 || status == 201) {
        // log(body);
        return Right(Right(body));
      } else {
        return Left(AppFailure.badRequest(errorMessage));
      }
    case 201:
      if (status == 200 || status == 201) {
        // log(body);
        return Right(Right(body));
      } else {
        return Left(AppFailure.badRequest(errorMessage));
      }
    case 400:
      log(statusCode.toString());
      return Left(AppFailure.badRequest(errorMessage));
    case 422:
      log(statusCode.toString());
      return Left(AppFailure.badRequest(errorMessage));
    case 401:
      log(statusCode.toString());
      return Left(AppFailure.badRequest(errorMessage));
    case 500:
      log(statusCode.toString());
      log(body["message"]);
      return Left(AppFailure.badRequest(errorMessage));

    default:
      return Left(AppFailure.badRequest(errorMessage));
  }
}
