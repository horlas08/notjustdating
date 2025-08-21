// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dartz/dartz.dart';

import '../core/failure/app_failure.dart';
import '../user_service/model/user_object.dart';
import 'models/location_model.dart';

abstract class IAuthFacade {
  Future<Either<AppFailure, Unit>> signInWithGoogle();
  Future<Either<AppFailure, Unit>> signInApple();
  Future<Either<AppFailure, Unit>> register(
      {required String? email, required String? userType});

  Future<Either<AppFailure, Unit>> verifyEmail(
      {required String? verificationCode});
  Future<Either<AppFailure, String>> updateDefaultPassword(
      {required String? newPassword, String? email});

  Future<Either<AppFailure, UserModel>> login(
      {required String? email, required String? password});
  Future<Either<AppFailure, String>> updateProfile({
    required String? preference,
    required String? relationship,
    required String? dob,
    String? userType,
    // required String? preference,
    required String? fullName,
    File? profilePhoto,
    List<String> interests,
    required String gender,
    String? username,
    // String? user_type,
    String? sexual_orientation,
    String? exercise,
    String? bio,
    String? job_title,
    String? employer,
    String? height,
    String? weight,
    String? education_level,
    String? no_of_kids,
    String? drinks,
    String? smokes,
    String? pets,
    String? religion,
    String? value,
    String? languages,
    String? address,
    num? long,
    num? lat,
  });
  Future<Either<AppFailure, String>> resendOtp(
      {required String email, required String userType});
  Future<Either<AppFailure, List<LocationModel>>> getLocations(
      {required String email, required String userType});
  Future<Either<AppFailure, Object>> editUserProfile({
    String? preference,
    String? relationship,
    String? dob,
    String? userType,
    //  String? preference,
    String? fullName,
    File? profilePhoto,
    List<String>? interests,
    String? gender,
    String? smokes,
    String? no_of_kids,
    String? drinks,
    String? exercise,
    String? education,
    String? sexual_orientation,
    String? weight,
    String? height,
    String? employer,
    String? job_title,
    String? religion,
    List<String>? languages,
    String? pets,
  });

  Future<Either<AppFailure, String>> updateUserInterests(
      {required List<String> interests});
  Future<void> logOutCurrentUser();
}
