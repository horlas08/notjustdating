import 'package:dartz/dartz.dart';
import 'package:ofwhich_v2/domain/core/failure/app_failure.dart';
import 'package:ofwhich_v2/domain/group/models/group_response.dart';

import 'models/chat_sdk_group_model.dart';
import 'models/group_model.dart';

abstract class GroupService {
  Future<Either<AppFailure, GroupResponse>> getGroups();
  Future<Either<AppFailure, GroupResponse>> getUserGroups();
  Future<Either<AppFailure, Object>> addMember({required int groupId});
  Future<Either<AppFailure, List<GroupModel>>> listGroupsWithoutSDK();
  Future<Either<AppFailure, Object>> updateSDKId(
      {required List<MiniChatGroupModel> groups});
}
