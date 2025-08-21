import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/core/failure/app_failure.dart';
import 'package:ofwhich_v2/domain/group/group_service.dart';
import 'package:ofwhich_v2/domain/group/models/group_model.dart';
import 'package:ofwhich_v2/domain/group/models/group_response.dart';

import '../../domain/group/models/chat_sdk_group_model.dart';
import '../../domain/http_service/http_service.dart';
import '../core/path.dart';

@LazySingleton(as: GroupService)
class IGroupRepo implements GroupService {
  final IHttpService _httpService;

  IGroupRepo({required IHttpService httpService}) : _httpService = httpService;
  @override
  Future<Either<AppFailure, GroupResponse>> getGroups() async {
    final failureOrSuccessOption =
        await _httpService.getData(path: Paths.getGroups);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      GroupResponse groupResponse = GroupResponse.fromMap(r.value["data"]);
      log(groupResponse.toString());
      return right(groupResponse);
    });
  }

  @override
  Future<Either<AppFailure, Object>> addMember({required int groupId}) async {
    var payload = {"group_id": groupId};
    final failureOrSuccessOption =
        await _httpService.post(payload: payload, path: Paths.addMember);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      String message = r.value["message"];
      return right(message);
    });
  }

  @override
  Future<Either<AppFailure, List<GroupModel>>> listGroupsWithoutSDK() async {
    final failureOrSuccessOption =
        await _httpService.getData(path: Paths.listwithoutsdk);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      List<GroupModel> groups =
          List.from(r.value["data"].map((e) => GroupModel.fromMap(e)));
      return right(groups);
    });
  }

  @override
  Future<Either<AppFailure, Object>> updateSDKId(
      {required List<MiniChatGroupModel> groups}) async {
    var payload = {
      "groups": groups
          .map((e) => MiniChatGroupModel(id: e.id, sdk_id: e.sdk_id).toMap())
          .toList()
    };
    final result =
        await _httpService.post(payload: payload, path: Paths.updateSdkId);
    return result.fold((l) {
      return left(l);
    }, (r) {
      var result = r.value["data"];
      return right(result);
    });
  }

  @override
  Future<Either<AppFailure, GroupResponse>> getUserGroups() async {
    final failureOrSuccessOption =
        await _httpService.getData(path: Paths.getUserGroups);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      GroupResponse groupResponse = GroupResponse.fromMap(r.value["data"]);
      log(groupResponse.toString());
      return right(groupResponse);
    });
  }
}
