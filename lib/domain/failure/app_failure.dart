import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

@freezed
abstract class AppFailure with _$AppFailure {
  const factory AppFailure.serverError(String? message) = ServerError;
  const factory AppFailure.badRequest(String? message) = BadRequest;
  const factory AppFailure.connectionTimeOut(String? message) =
      ConnectionTimeOut;
  const factory AppFailure.unAuthorized(String? message) = Unauthorized;
  const factory AppFailure.socketException(String? message) =
      AppSocketException;

  const factory AppFailure.notFound(String? message) = NotFound;
}
