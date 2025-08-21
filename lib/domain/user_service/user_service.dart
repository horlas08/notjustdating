// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ofwhich_v2/domain/core/failure/app_failure.dart';
import 'package:ofwhich_v2/domain/user_service/model/date_request_model.dart';

import '../../infrastructure/user/model/feed.dart';
import 'model/data_fetch_model.dart';
import 'model/date_payment_details.dart';
import 'model/firebase_user_model.dart';
import 'model/user_gift.dart';
import 'model/user_object.dart';

abstract class UserService {
  Future<Either<AppFailure, UserModel>> getUserProfile();
  Future<Either<AppFailure, FeedsModel>> getFeeds();
  Future<Either<AppFailure, FeedsModel>> getFilteredFeeds(
      {int? pagainationCount,
      int? locationId,
      int? radiusStart,
      int? radiusEnd,
      int? ageRangeStart,
      int? ageRangeEnd});
  Future<Either<AppFailure, List<UserFromFirestore>>> getUsers();
  Future<Either<AppFailure, bool>> likeProfile({required String? userId});
  Future<Either<AppFailure, String>> uploadUserPhoto({required File file});
  Future<Either<AppFailure, List<UserModel>>> getUserList(
      {required int pageCount});
  Future<Either<AppFailure, String>> updateProfile(
      {required String? preference,
      required String? relationship,
      required String? dob,
      String? userType,
      // required String? preference,
      required String? fullName,
      required File profilePhoto,
      required List<String> interests,
      required String gender});
  Future<Either<AppFailure, List<UserModel>>> getMatchedUserList();
  Future<Either<AppFailure, List<UserModel>>> getProfileLikes();
  Future<Either<AppFailure, List<UserGift>>> getGifts();
  Future<Either<AppFailure, String>> sendGift(
      {required num amount,
      int? quantity,
      int? beneficiaryId,
      String? paymentMethod,
      int? pin,
      int? giftId});

  Future<Either<AppFailure, DatePaymentData>> sendDateRequest(
      {DateRequestModel? dateReq,

      /// takes id of person for date
      num? requestedId,

      /// date request id
      num? request_id,
      required String type});

  Future<Either<AppFailure, List<DateFetchModel>>> fetchDataRequests(
      {String? filter});

  Future<Either<AppFailure, String>> rejectDateRequest({
    /// date request id
    num? request_id,
  });

  Future<Either<AppFailure, String>> updateDateRequestPayment(
      {required String reference_id, required String payment_initiator_type});
}
