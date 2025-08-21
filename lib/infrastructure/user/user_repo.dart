// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/core/failure/app_failure.dart';
import 'package:ofwhich_v2/domain/http_service/http_service.dart';
import 'package:ofwhich_v2/domain/user_service/model/data_fetch_model.dart';
import 'package:ofwhich_v2/domain/user_service/model/date_request_model.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_gift.dart';
// import 'package:ofwhich_v2/domain/user_service/model/firebase_user_model.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/domain/user_service/user_service.dart';

import '../../domain/user_service/model/date_payment_details.dart';
import '../../domain/user_service/model/firebase_user_model.dart';
import '../core/path.dart';
import 'model/feed.dart';

@LazySingleton(as: UserService)
class IUserRepo implements UserService {
  final IHttpService httpService;
  final FirebaseFirestore _firebaseFirestore;
  IUserRepo(this.httpService, this._firebaseFirestore);
  @override
  Future<Either<AppFailure, UserModel>> getUserProfile() async {
    final failureOrSuccessOption =
        await httpService.getData(path: Paths.getUserProfile);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      UserModel userModel = UserModel.fromMap(r.value["data"]);
      return right(userModel);
    });
  }

  @override
  Future<Either<AppFailure, FeedsModel>> getFeeds() async {
    final failureOrSuccessOption =
        await httpService.getData(path: "${Paths.getFeed}pagination_count=15");
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      FeedsModel feeds = FeedsModel.fromMap(r.value["data"]);
      return right(feeds);
    });
  }

  @override
  Future<Either<AppFailure, bool>> likeProfile(
      {required String? userId}) async {
    var payload = {"user_id": userId};
    final failureOrSuccessOption =
        await httpService.post(path: Paths.likeUser, payload: payload);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      bool isMatched = r.value['data']['matched'];
      return right(isMatched);
    });
  }

  @override
  Future<Either<AppFailure, List<UserFromFirestore>>> getUsers() async {
    try {
      final result = await _firebaseFirestore.collection("users").get();
      List<UserFromFirestore> users = result.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return UserFromFirestore.fromMap(data);
      }).toList();

      return right(users);
    } catch (e) {
      return left(AppFailure.badRequest(e.toString()));
    }
    // failureOrSuccessOption.
  }

  @override
  Future<Either<AppFailure, String>> uploadUserPhoto(
      {required File file}) async {
    final failureOrSuccessOption = await httpService.postFormData(
        path: Paths.uploadPhoto, payload: {}, file: file, imageKey: "picture");
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      String message = r.value['data'];
      return right(message);
    });
  }

  @override
  Future<Either<AppFailure, List<UserModel>>> getUserList(
      {required int pageCount}) async {
    final failureorSuccessOption =
        await httpService.getData(path: "${Paths.getUser}$pageCount");
    return failureorSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      List<UserModel> userModelList =
          List.from(r.value["data"]["users"].map((e) => UserModel.fromMap(e)));
      return right(userModelList);
    });
  }

  @override
  Future<Either<AppFailure, String>> updateProfile(
      {required String? preference,
      required String? relationship,
      required String? dob,
      String? userType,
      required String? fullName,
      required File profilePhoto,
      required List<String> interests,
      required String gender}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

//todo:add pagination!!!!!!!!!!
  @override
  Future<Either<AppFailure, List<UserModel>>> getMatchedUserList() async {
    final failureOrSuccesopion =
        await httpService.getData(path: Paths.getMatchedUsers);
    return failureOrSuccesopion.fold((l) {
      return left(l);
    }, (r) {
      List<UserModel> userModelList =
          List.from(r.value["data"]["users"].map((e) => UserModel.fromMap(e)));
      return right(userModelList);
    });
  }

  @override
  Future<Either<AppFailure, List<UserModel>>> getProfileLikes() async {
    final failureOrSuccessOption =
        await httpService.getData(path: Paths.getProfileLikes);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      List<UserModel> profileLikes =
          List.from(r.value["data"]["users"].map((e) => UserModel.fromMap(e)));
      return right(profileLikes);
    });
  }

  @override
  Future<Either<AppFailure, FeedsModel>> getFilteredFeeds(
      {int? pagainationCount,
      int? radiusStart,
      int? radiusEnd,
      int? locationId,
      int? ageRangeStart,
      int? ageRangeEnd}) async {
    const paginationCount = 20;
    final failureOrSuccessOption = await httpService.getData(
        path:
            "${Paths.getFeed}pagination_count=$paginationCount&radius[start]=$radiusStart&radius[end]=$radiusEnd&age_range[start]=$ageRangeStart&age_range[end]=$ageRangeEnd&location_id=$locationId");
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      FeedsModel feeds = FeedsModel.fromMap(r.value["data"]);
      return right(feeds);
    });
  }

  @override
  Future<Either<AppFailure, List<UserGift>>> getGifts() async {
    final failureOrSuccessOption =
        await httpService.getData(path: Paths.getGifts);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      List<UserGift> giftList =
          List.from(r.value["data"]['gifts'].map((e) => UserGift.fromMap(e)));
      return right(giftList);
    });
  }

  @override
  Future<Either<AppFailure, String>> sendGift(
      {required num amount,
      int? quantity,
      int? beneficiaryId,
      String? paymentMethod,
      int? pin,
      int? giftId}) async {
    var payload = {
      "amount": amount,
      "beneficiary_id": beneficiaryId,
      "payment_method": paymentMethod,
      "transaction_pin": pin,
      "gift_id": giftId
    };
    final failureOrSuccessOption =
        await httpService.post(payload: payload, path: Paths.sendGift);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      var message = r.value["message"];
      return right(message);
    });
  }

  @override
  Future<Either<AppFailure, DatePaymentData>> sendDateRequest(
      {DateRequestModel? dateReq,
      num? requestedId,
      num? request_id,
      required String type}) async {
    //!takes id of person for date
    var requestingDate = {
      "requested_id": requestedId,
      "request_initiator_type": "requester",
      "budget": dateReq?.budget,
      "payment_method": dateReq?.payment_method,
      "locations": dateReq?.locations,
      "availability_options": dateReq?.availability_options
    };
    //!takes id ofr daterequest
    var acceptingDateInvite = {
      'request_id': request_id,
      "request_initiator_type": "requested",
      "budget": dateReq?.budget,
      "payment_method": dateReq?.payment_method,
      "locations": dateReq?.locations,
      "availability_options": dateReq?.availability_options
    };
    final failureOrSuccessOption = await httpService.post(
        payload: type == "requester" ? requestingDate : acceptingDateInvite,
        path: Paths.storeDate);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      var result = DatePaymentData.fromMap(r.value['data']['payment_data']);
      return right(result);
    });
  }

  @override
  Future<Either<AppFailure, List<DateFetchModel>>> fetchDataRequests(
      {String? filter}) async {
    var path = filter == null
        ? "/user/date/requests/list"
        : "/user/date/requests/list?filter=requested";
    final failureOrSuccessOption = await httpService.getData(path: path);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      log("responseeeee:$r");
      List<DateFetchModel> resultData = List.from(r.value["data"]
              ["date_requests"]
          .map((e) => DateFetchModel.fromJson(e)));
      return right(resultData);
    });
  }

  @override
  Future<Either<AppFailure, String>> rejectDateRequest({
    num? request_id,
  }) async {
    var payload = {"id": request_id};

    final failureOrSuccessOption =
        await httpService.post(payload: payload, path: Paths.rejectDate);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      return right(r.value['message']);
    });
  }

  @override
  Future<Either<AppFailure, String>> updateDateRequestPayment(
      {required String reference_id,
      required String payment_initiator_type}) async {
    var payload = {
      "reference_id": reference_id,
      "payment_initiator_type": payment_initiator_type
    };
    final result =
        await httpService.post(payload: payload, path: Paths.updateDatePayment);
    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r.value['message']);
    });
  }
}
