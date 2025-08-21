// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/auth/models/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../domain/auth/i_auth_facade.dart';
import '../../domain/core/constants/error_messages.dart';
import '../../domain/core/failure/app_failure.dart';
import '../../domain/http_service/http_service.dart';
import '../../domain/user_service/model/user_object.dart';
import '../core/path.dart';

@LazySingleton(as: IAuthFacade)
class IAuthRepo implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;

  final GoogleSignIn _googleSignIn;
  final SignInWithApple _appleSignIn;
  final IHttpService _httpService;
  // final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  IAuthRepo(this._firebaseAuth, this._googleSignIn, this._appleSignIn,
      this._httpService, this._firebaseFirestore);
  @override
  Future<Either<AppFailure, Unit>> signInApple() async {
    final appleUser = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    if (appleUser == null) {
      return left(AppFailure.badRequest(ErrorMessages().serverErrorString));
    } else {
      // return _firebaseAuth
      //     .signInWithCredential(authCredential)
      //     .then((r) => right(unit));
      final apple = appleUser.userIdentifier;
      final authCredential = GoogleAuthProvider.credential(
          idToken: appleUser.identityToken,
          accessToken: appleUser.authorizationCode);
      return _firebaseAuth
          .signInWithCredential(authCredential)
          .then((r) => right(unit));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    try {
      if (googleUser == null) {
        print("error signin using google");
        return left(AppFailure.badRequest(ErrorMessages().serverErrorString));
      }
      final googleAuthentication = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken);
      return _firebaseAuth.signInWithCredential(authCredential).then((r) {
        _firebaseFirestore
            .collection("users")
            .doc(googleUser.email)
            .set({"email": googleUser.email});
        return right(unit);
      });
    } on FirebaseAuthException catch (_) {
      return left(AppFailure.serverError(ErrorMessages().serverErrorString));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> register(
      {required String? email, required String? userType}) async {
    var payload = {"email": email, "user_type": userType};
    final failureOrSuccessOption =
        await _httpService.post(payload: payload, path: Paths.register);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = r.value["data"]["access_token"];
      prefs.setString('token', token);
      prefs.setString("email", email!);

      return right(unit);
    });
  }

  @override
  Future<Either<AppFailure, Unit>> verifyEmail(
      {required String? verificationCode}) async {
    var payload = {"verification_code": verificationCode};
    final failureOrSuccessOption =
        await _httpService.post(payload: payload, path: Paths.verifyEmail);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      return right(unit);
    });
  }

  @override
  Future<Either<AppFailure, String>> updateDefaultPassword(
      {required String? newPassword, String? email}) async {
    var payload = {"password": newPassword};
    final failureOrSuccessOption = await _httpService.post(
        payload: payload, path: Paths.updateDefaultPassword);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) async {
      String data = r.value["message"];
      var result =
          await createFirebaseUser(email: email ?? "", password: newPassword!);
      result.fold((l) {
        return left(l);
      }, (r) {
        return r;
      });
      return right(data);
    });
  }

  @override
  Future<Either<AppFailure, UserModel>> login(
      {required String? email, required String? password}) async {
    var payload = {"email": email, "password": password};
    final failureOrSuccessOption =
        await _httpService.post(payload: payload, path: Paths.login);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) async {
      UserModel user = UserModel.fromMap(r.value["data"]["user"]);
      // String data = r.value["message"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = r.value["data"]["access_token"];
      // String? accessToken = prefs.getString('token');
      prefs.setString("token", token);
      var result =
          await loginFirebaseUser(email: email ?? "", password: password ?? "");

      var userPayload = {"email": email, "password": password};
      prefs.setString("firebaseUser", userPayload.toString());
      result.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
      // _firebaseFirestore.collection("users").doc(email).set(
      //     {"userName": user.fullName, "userId": user.id.toString()},
      //     SetOptions(merge: true));
      saveUserLocally(user: user);
      return right(user);
    });
  }

  @override
  Future<Either<AppFailure, String>> updateProfile({
    required String? preference,
    required String? relationship,
    required String? dob,
    String? userType,
    // required String? preference,
    required String? fullName,
    String? username,
    File? profilePhoto,
    List<String>? interests,
    required String gender,
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
  }) async {
    var contentCreatorPayload = {
      "full_name": fullName!,
      "gender": gender.toLowerCase(),
      "dob": dob!,
      "username": fullName,
    };
    var payload = {
      "preference": preference == null ? "n/a" : preference.toLowerCase(),
      "relationship_status":
          relationship == null ? "n/a" : relationship.toLowerCase(),
      "full_name": fullName,
      "gender": gender.toLowerCase(),
      "dob": dob,
      "username": username ?? fullName,
      "pets": pets ?? "Dogs".toLowerCase(),
      "religion": religion ?? "christianity",
      "job_title": job_title ?? "Project Manager".toLowerCase(),
      "drinks": drinks ?? "never",
      "smokes": smokes ?? "never",
      "education_level": education_level ?? "graduate school".toLowerCase(),
      "no_of_kids": no_of_kids == null ? "0" : no_of_kids.toString(),
      "address": address ?? "N/A", "longitude": long.toString(),
      "latitude": lat.toString(),
      // "value": value ?? "Family",
      "employer": employer ?? "No one",
      "bio": bio ?? "About",
      "height": height ?? "90",
      "weight": weight ?? "90",
      "exercise": exercise ?? "regularly",
      "sexual_orientation": sexual_orientation ?? "asexual",
      "value": value ?? "Beauty & Art".toLowerCase()
    };
    print("payload::::" + payload.toString());
    log(payload.toString());
    final failureOrSuccessOption = await _httpService.postFormDataWithFiles(
        listData: interests,
        listKey: "interests",
        data: profilePhoto,
        payload: userType == "user" ? payload : contentCreatorPayload,
        path: Paths.profileUpdate);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      String data = r.value["message"];
      UserModel user = UserModel.fromMap(r.value['data']);
      saveUserLocally(user: user);
      return right(data);
    });
  }

  @override
  Future<Either<AppFailure, String>> resendOtp(
      {required String email, required String userType}) async {
    // var payload = {"verification_code": verificationCode};
    // log(payload.toString());
    var payload = {"email": email, "user_type": userType};
    final failureOrSuccessOption =
        await _httpService.post(payload: payload, path: Paths.resentOtp);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      String data = r.value["message"];
      return right(data);
    });
  }

  saveUserLocally({required UserModel user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = json.encode(user.toMap());
    prefs.setString('user', userString);
  }

  @override
  Future<Either<AppFailure, List<LocationModel>>> getLocations(
      {required String email, required String userType}) async {
    final failureOrSuccessOption =
        await _httpService.getData(path: Paths.getLocations);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      // log(r.value);
      List<LocationModel> locationList =
          List.from(r.value["data"].map((e) => LocationModel.fromMap(e)));
      return right(locationList);
    });
  }

  @override
  Future<Either<AppFailure, Object>> editUserProfile(
      {String? preference,
      String? relationship,
      String? dob,
      String? userType,
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
      String? pets}) async {
    var contentCreatorPayload = {
      "full_name": fullName!,
      "gender": gender!.toLowerCase(),
      "dob": dob!,
      "username": fullName,
    };
    var payload = {
      "preference": preference == null ? "n/a" : preference.toLowerCase(),
      "relationship_status":
          relationship == null ? "n/a" : relationship.toLowerCase(),
      "full_name": fullName,
      "gender": gender.toLowerCase(),
      "dob": dob,
      "username": fullName,
      // "religion": religion ?? "christianity",
      // "smokes": smokes ?? "never",
    };
    log(payload.toString());
    final failureOrSuccessOption = await _httpService.postFormDataWithFiles(
        listData: interests,
        listKey: "interests",
        data: profilePhoto,
        payload: userType == "user" ? payload : contentCreatorPayload,
        path: Paths.profileUpdate);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      String data = r.value["message"];
      UserModel user = UserModel.fromMap(r.value['data']);
      saveUserLocally(user: user);
      return right(data);
    });
  }

  Future<Either<AppFailure, bool>> createFirebaseUser(
      {required String email, required String password}) async {
    try {
      // UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(true);
    } on FirebaseAuthException catch (e) {
      String message = ErrorMessages().serverErrorString;
      if (e.code == "email-already-in-use") {
        message = "email already in use";
        return left(AppFailure.badRequest(message));
      } else if (e.code == "weak-password") {
        message = "password is too weak";
        return left(AppFailure.badRequest(message));
      } else {
        return left(AppFailure.badRequest(e.toString()));
      }
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> loginFirebaseUser(
      {required String email, required String password}) async {
    try {
      // UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(true);
    } on FirebaseAuthException catch (e) {
      String message = ErrorMessages().serverErrorString;
      if (e.code == "user-not-found") {
        message = "no user found with entered email";
        return left(AppFailure.badRequest(message));
      } else if (e.code == "wrong password") {
        message = "invalid login credentials";
        return left(AppFailure.badRequest(message));
      } else {
        return left(AppFailure.badRequest(e.toString()));
      }
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  Future<Either<AppFailure, User>> signInAnonymously() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      return right(userCredential.user!);
    } catch (e) {
      log("Error signing in anonymously: $e");
      return left(AppFailure.badRequest(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> updateUserInterests(
      {required List<String> interests}) async {
    var payload = {"interests": interests};
    print(payload.toString());
    var result = await _httpService.post(
        payload: payload, path: Paths.updateUserInterest);
    return result.fold((l) => left(l), (r) {
      var message = r.value['message'];
      return right(message);
    });
  }

  @override
  Future<void> logOutCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "");
    prefs.setString("email", "");
  }
}
