import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_file.dart';
import 'package:quickblox_sdk/models/qb_filter.dart';
import 'package:quickblox_sdk/models/qb_session.dart';
import 'package:quickblox_sdk/models/qb_sort.dart';
import 'package:quickblox_sdk/models/qb_user.dart';

import '../core/failure/app_failure.dart';
import '../user_service/model/user_object.dart';

abstract class ChatService {
  Future<void> sendMessage(
      {required String receiverId, required String message});
  Stream<QuerySnapshot> getMessages(
      {required String userId, required String otherUserId});
  Future<UserModel> getSavedUser();
  Future<Either<AppFailure, String>> uploadFile(
      {required File file, String? destination});

  Future<Either<AppFailure, Object>> createQBUser(
      {required String login, required String password, String? fullname});
  Future<void> initializeChat();
  Future<Either<AppFailure, QBSession>> authennticateUser(
      {required String login, required String password});
  Future<Either<AppFailure, Unit>> connectToChat(
      {required String userId, required String password});
  //       List<int> occupantsIds = [140166913, 140166978];
  // String dialogName = "test dialog";
  // int dialogType = QBChatDialogTypes.GROUP_CHAT;
  Future<Either<AppFailure, String>> createPersonalChatDialog(
      {required List<int> occupantsId,
      required String chatName,
      required int dialogType});
  Future<Either<AppFailure, List<int>>> getAllUserIds();
  Future<Either<AppFailure, Unit>> createGroupChatDialog();
  Future<Either<AppFailure, Unit>> sendMessageQB(
      {required String dialogId, required String message});
  Stream<Object> subScribeToChat();
  Future<Either<AppFailure, List<Object>>> getDialogMessages(
      {required String dialogId});
  Future<Either<AppFailure, Object>> getQBCurrentUser();
  Future<Either<AppFailure, Unit>> disconnectFromChat();
  // Future<Either<AppFailure, bool?>> isConected();
  Future<Either<AppFailure, bool>> pingUser({required int userId});
  Future<Either<AppFailure, List<QBDialog>>> loadDialogs(
      {QBSort? sort, QBFilter? filter, int? limit, int? skip});
  Future<Either<AppFailure, QBDialog>> getDialog({String? dialogId});
  Future<Either<AppFailure, QBDialog?>> searchDialogByName({String? dialogName});
  Future<Either<AppFailure, Unit>> deleteDialog({String? dialogId});
  Future<Either<AppFailure, Unit>> joinDialog({String? dialogId});
  Future<Either<AppFailure, List<int>>> getOnlineUsers(
      {required String dialogId});
  Future<Either<AppFailure, Unit>> sendIsTyping({String? dialogId});
  Future<Either<AppFailure, Unit>> sendIsTypingStopped({String? dialogId});
  Future<Either<AppFailure, Object>> uploadQBFile({required File file});
  Future<Either<AppFailure, Unit>> sendMessageWithAttachment(
      {required String dialogId, required QBFile qbFile, String? fileType});
  Future<Either<AppFailure, Unit>> updateDialog(
      {required int userId, required String dialogId});
  Future<Either<AppFailure, QBDialog>> updateDialogOccupants(
      {required String dialogId, required List<int> addUsers});
  Future<Either<AppFailure, Unit>> logOutQBUser();
  Future<Either<AppFailure, Unit>> storeSdkChatHistory(
      {required List<dynamic> usersIds, required String sdkChatId});

  Future<Either<AppFailure, String>> getChatHistoryWithParticularUser(
      {required List<int> userId});
  Future<Either<AppFailure, List<QBUser>>> fetchUserbyEmailOrLogin(
      {String? login, String? email});

  Future<Either<AppFailure, Unit>> sendMessageQBPrivateChat(
      {required String dialogId, required String message});

  Future<Either<AppFailure, List<Object>>> getUsersInDialog(
      {required String dialogId});
  Future<Either<AppFailure, List<Object>>> getUsersByIds(
      {required List<int> ids});
  Future<Either<AppFailure, List<QBDialog>>> getPrivateDialogs();
  Future<Either<AppFailure, QBDialog>> getDialogsWithLastMessage(
      {required QBDialog dialog});
  Future<Either<AppFailure, QBUser>> updateUseDetails(
      {String? fullName,
      String? login,
      String? email,
      String? phone,
      String? age,
      String? city});

  Future<Either<AppFailure, String>> reportMessage(
      {int? reportedUserId, String? reportedContent});
}
