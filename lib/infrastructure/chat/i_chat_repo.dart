import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/core/constants/error_messages.dart';
import 'package:ofwhich_v2/domain/core/failure/app_failure.dart';
import 'package:ofwhich_v2/infrastructure/chat/message.dart';
import 'package:ofwhich_v2/infrastructure/core/path.dart';
import 'package:path/path.dart';
import 'package:quickblox_sdk/auth/module.dart';
import 'package:quickblox_sdk/mappers/qb_user_mapper.dart';
import 'package:quickblox_sdk/models/qb_attachment.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_file.dart';
import 'package:quickblox_sdk/models/qb_filter.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/models/qb_session.dart';
import 'package:quickblox_sdk/models/qb_sort.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/users/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/chat/chat_service.dart';
import '../../domain/http_service/http_service.dart';
import '../../domain/user_service/model/user_object.dart';
import "extension_on_qbuser.dart";

@LazySingleton(as: ChatService)
class ChatRepo implements ChatService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final IHttpService _httpService;
  UserModel? user;

  ChatRepo(this._firebaseAuth, this._firebaseFirestore, this.firebaseStorage,
      this._httpService);
  @override
  Future<void> sendMessage(
      {required String receiverId, required String message}) async {
    UserModel currentUser = await getUserSavedLocally();
    final String currentUserId = currentUser.id.toString();
    final String currentUserEmail =
        currentUser.full_name.toString() ?? "odunayoojomo0@gmail.com";
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);
    List<String> ids = [currentUserId, receiverId];
    ids.sort();

    String chatRoomId = ids.join("_");
    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  @override
  Stream<QuerySnapshot> getMessages(
      {required String userId, required String otherUserId}) {
    List<String> ids = [userId, otherUserId];
    // log(ids.toString());
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firebaseFirestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Future<UserModel> getUserSavedLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = prefs.getString("user") ?? "";
    UserModel user = UserModel.fromMap(json.decode(userString));
    log(user.toMap().toString());
    return user;
    // notifyListeners();
  }

  @override
  Future<UserModel> getSavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = prefs.getString("user") ?? "";
    UserModel user = UserModel.fromMap(json.decode(userString));
    log(user.toMap().toString());
    return user;
  }

  @override
  Future<Either<AppFailure, String>> uploadFile(
      {required File file, String? destination}) async {
    if (file.path != "") {
      final filename = basename(file.path);
      const destination = 'images/';

      try {
        final ref = firebaseStorage.ref(destination).child("$filename/");
        await ref.putFile(file);
        final link = await ref.getDownloadURL();
        return right(link);
      } catch (e) {
        return left(AppFailure.serverError(e.toString()));
      }
    } else {
      return left(const AppFailure.badRequest("Select an image to upload"));
    }
  }

// test credenntials
  @override
  Future<Either<AppFailure, QBSession>> authennticateUser(
      {required String login, required String password}) async {
    try {
      QBLoginResult result = await QB.auth.login(login, password);
      QBUser qbUser = result.qbUser!;
      saveQBCurrentUser(user: qbUser);
      QBSession qbSession = result.qbSession!;
      await QB.chat.connect(qbUser.id ?? 0, password);
      return right(qbSession);
    } on PlatformException catch (e) {
      return left(AppFailure.serverError(e.message));
      // Some error occurred, look at the exception message for more details
    }
  }

  SharedPreferences? prefs;
  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveQBCurrentUser({required QBUser user}) async {
    await initPrefs();
    prefs?.setString("qbUser", json.encode(QBUserHelper.toJson(user)));
  }

// test credentials
  @override
  Future<Either<AppFailure, Unit>> connectToChat(
      {required String userId, required String password}) async {
    try {
      await QB.chat.disconnect();
      await QB.chat.connect(int.parse(userId), password);
      return right(unit);
    } on PlatformException catch (e) {
      return left(AppFailure.badRequest(e.message));
      // Some error occurred, look at the exception message for more details
    }
  }

  @override
  Future<Either<AppFailure, Unit>> createGroupChatDialog() {
    // TODO: implement createGroupChatDialog
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, String>> createPersonalChatDialog(
      {required List<int> occupantsId,
      required String chatName,
      required int dialogType}) async {
    try {
      QBDialog? createdDialog = await QB.chat.createDialog(
        dialogType,
        occupantsIds: occupantsId,
        dialogName: chatName,
      );

      // QB.chat.joinDialog(dialogId)
      if (createdDialog != null) {
        String dialogId = createdDialog.id!;
        // QB.chat.joinDialog(_dialogId);
      }
      return right(createdDialog?.id ?? "n/a");
    } on PlatformException catch (e) {
      return left(AppFailure.badRequest(e.toString()));
      // Some error occurred, look at the exception message for more details
    }
  }

  String appId = "103981";
  String authKey = "ak_hCRFEUCVOq8Zqg-";
  String authSecret = "as_sASuRxSFKDLzpNW";
  String accountKey = "ack__Bb42KCwRre-2c4zsPVH";
//test credentials
  @override
  Future<void> initializeChat() async {
    try {
      await QB.settings.init(
          dotenv.env['APPID'] ?? "",
          dotenv.env['AUTHKEY'] ?? "",
          dotenv.env['AUTHSECRET'] ?? "",
          dotenv.env['ACCOUNTKEY'] ?? "");
    } on PlatformException catch (e) {
      log(e.message ?? ErrorMessages().badRequestString);
      // Some error occurred, look at the exception message for more details
    }
  }

  @override
  Future<Either<AppFailure, Unit>> sendMessageQB(
      {required String dialogId, required String message}) async {
    try {
      // QBUser
      await QB.chat.joinDialog(dialogId);
      await QB.chat.sendMessage(dialogId, body: message, saveToHistory: true);
      return right(unit);
    } on PlatformException catch (e) {
      return left(AppFailure.serverError(e.message));
      // Some error occured, look at the exception message for more details
    }
  }

  StreamSubscription? someSubscription;
  String event = QBChatEvents.RECEIVED_NEW_MESSAGE;

  @override
  Stream<Object> subScribeToChat() async* {
    final controller = StreamController<Object>();

    try {
      someSubscription = await QB.chat.subscribeChatEvent(
        event, // Replace with your actual event
        (data) {
          log("data:::::::::: $data");
          Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);
          Map<dynamic, dynamic> payload =
              Map<dynamic, dynamic>.from(map["payload"]);
          String messageId = payload["id"] as String;
          controller.add(messageId);
        },
      );
    } catch (e) {
      controller.add(Left(AppFailure.serverError(e.toString())));
    }

    yield* controller.stream;
  }

  @override
  Future<Either<AppFailure, List<Object>>> getDialogMessages(
      {required String dialogId}) async {
    try {
      var result = await QB.chat.getDialogMessages(dialogId);
      List<QBMessage> messageList = List.from(result);
      return right(messageList);
    } catch (e) {
      return left(AppFailure.badRequest(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Object>> getQBCurrentUser() async {
    try {
      await initPrefs();
      var result = prefs!.getString("qbUser");
      if (result != null) {
        QBUser user =
            QBUserMapper.mapToQBUser(json.decode(result!)) ?? QBUser();
        return right(user);
      } else {
        return left(const AppFailure.badRequest("No loggedin user"));
      }
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Object>> createQBUser(
      {required String login,
      required String password,
      String? fullname}) async {
    try {
      final response = await QB.users
          .createUser(login, password, fullName: fullname, email: login);
      return right(response ?? QBUser());
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> deleteDialog({String? dialogId}) async {
    try {
      await QB.chat.deleteDialog(dialogId ?? "N/A");
      return right(unit);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> disconnectFromChat() async {
    try {
      await QB.chat.disconnect();
      return right(unit);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, QBDialog>> getDialog({String? dialogId}) async {
    try {
      QBFilter filter = QBFilter();
      filter.field = QBChatDialogFilterFields.ID;
      filter.operator = QBChatDialogFilterOperators.IN;
      filter.value = dialogId;

      List<QBDialog?> dialogList = await QB.chat.getDialogs(filter: filter);

      // Check if the dialogList is not empty
      if (dialogList.isNotEmpty && dialogList.first != null) {
        QBDialog dialog = dialogList.first!;
        return right(dialog);
      } else {
        // Handle the case where no dialog was found
        return left(
            const AppFailure.serverError("No dialog found with the given ID."));
      }
    } catch (e) {
      // Catch and handle any errors that occur
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<int>>> getOnlineUsers(
      {required String dialogId}) async {
    try {
      var result = await QB.chat.getOnlineUsers(dialogId) as List<int>;
      return right(result);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  // @override
  // Future<Either<AppFailure, bool?>> isConected() async {
  //   try {
  //     var result = await QB.chat.isConnected() ?? false;
  //     right(result);
  //   } catch (e) {
  //     return left(AppFailure.serverError(e.toString()));
  //   }

  // }

  @override
  Future<Either<AppFailure, Unit>> joinDialog({String? dialogId}) async {
    try {
      // await QB.chat.leaveDialog(dialogId ?? "");
      await QB.chat.joinDialog(dialogId ?? "");
      return right(unit);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<QBDialog>>> loadDialogs(
      {QBSort? sort, QBFilter? filter, int? limit, int? skip}) async {
    try {
      var result = await QB.chat.getDialogs(
          sort: sort,
          filter: filter,
          limit: limit,
          skip: skip) as List<QBDialog>;
      return right(result);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, bool>> pingUser({required int userId}) async {
    try {
      final result = await QB.chat.pingUser(userId);
      return right(result);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> sendIsTyping({String? dialogId}) async {
    try {
      await QB.chat.sendIsTyping(dialogId ?? "n/a");

      return right(unit);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> sendIsTypingStopped(
      {String? dialogId}) async {
    try {
      await QB.chat.sendStoppedTyping(dialogId ?? "n/a");

      return right(unit);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> sendMessageWithAttachment(
      {required String dialogId,
      required QBFile qbFile,
      String? fileType}) async {
    try {
      // Create an attachment
      QBAttachment attachment = QBAttachment();
      attachment.id = qbFile.uid;
      attachment.type =
          fileType ?? "image"; // Adjust the type based on your file type

      // Create the message
      QBMessage message = QBMessage();
      message.dialogId = dialogId.toString(); // Set dialog ID
      // message.attachments = [attachment]; // Set the attachment list
      // message.body = "Here is an attachment"; // Optional message body

      // Send the message
      // await QB.chat.joinDialog(dialogId);

      await QB.chat.sendMessage(dialogId,
          attachments: [attachment],
          body: "Attachment sent",
          saveToHistory: true);
      debugPrint("Message sent with attachment");
      return right(unit);
    } catch (e) {
      debugPrint("Error sending message with attachment: $e");
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Object>> uploadQBFile({required File file}) async {
    try {
      QBFile? qbFile = await QB.content.upload(file.path);
      if (qbFile == null) {
        return right(QBFile());
      } else {
        return right(qbFile);
      }
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> updateDialog(
      {required int userId, required String dialogId}) async {
    try {
      await QB.chat
          .updateDialog(dialogId, addUsers: [140248027], removeUsers: []);

      return right(unit);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<int>>> getAllUserIds() async {
    try {
      // Fetch all users without any specific filters
      List<QBUser?> users = await QB.users.getUsers();

      // Extract the user IDs from the list of users
      List<int> userIds = users
          .where((user) => user != null) // Check if the user is not null
          .map((user) => user!.id!) // Safely access the user ID
          .toList(); // Convert the result to a list

      // Print the list of user IDs for verification
      log('Fetched User IDs: $userIds');

      return right(userIds); // Return the list of user IDs
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  void logoutUser() {}

  @override
  Future<Either<AppFailure, Unit>> logOutQBUser() async {
    try {
      debugPrint("Left all dialogs.");

      // Disconnect chat and terminate sessions
      await QB.chat.disconnect();
      await QB.auth.logout();
      // await QB.auth.clearSession();
      return right(unit);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> storeSdkChatHistory(
      {required List usersIds, required String sdkChatId}) async {
    var payload = {"user_ids": usersIds, "sdk_chat_id": sdkChatId};
    final result = await _httpService.post(
        payload: payload, path: Paths.storeSDKChatHistory);
    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r.value);
    });
  }

  @override
  Future<Either<AppFailure, String>> getChatHistoryWithParticularUser(
      {required List<int> userId}) async {
    final result = await _httpService.getData(
        path:
            "${Paths.checkHistory}user_ids[]=${userId[0]}&user_ids[]=${userId[0]}");
    return result.fold((l) {
      return left(l);
    }, (r) {
      if (r.value["data"]["sdk_chat_id"] != null) {
        String dialogId = r.value["data"]["sdk_chat_id"];
        return right(dialogId);
      } else {
        return right("");
      }
    });
  }

  @override
  Future<Either<AppFailure, List<QBUser>>> fetchUserbyEmailOrLogin(
      {String? login, String? email}) async {
    try {
      // Define the filter to search by login or email
      QBFilter filter = QBFilter();

      if (login != null) {
        // Add filter by login
        filter.field = "login";
        // filter.operator = QBChatDialogFilterOperators.CTN; // EQ stands for equal
        filter.value = login;
      } else if (email != null) {
        // Add filter by email
        filter.field = "email";
        // filter.operator = QBFilterOperator.EQ; // EQ stands for equal
        filter.value = email;
      } else {
        log("Please provide either login or email to fetch the user.");
        return left(const AppFailure.badRequest("An error occurred"));
      }

      // Fetch users based on the filter

      List<QBUser?> users = await QB.users.getUsers(filter: filter);
      List<QBUser> nonNullUsers =
          users.where((user) => user != null).cast<QBUser>().toList();

      return right(nonNullUsers);
    } on PlatformException catch (e) {
      // Handle error if user retrieval fails
      log("Error fetching user: ${e.message}");
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> sendMessageQBPrivateChat(
      {required String dialogId, required String message}) async {
    try {
      // QBUser
      // await QB.chat.joinDialog(dialogId);
      await QB.chat.sendMessage(dialogId, body: message, saveToHistory: true);
      return right(unit);
    } on PlatformException catch (e) {
      return left(AppFailure.serverError(e.message));
      // Some error occured, look at the exception message for more details
    }
  }

  @override
  Future<Either<AppFailure, List<Object>>> getUsersByIds(
      {required List<int> ids}) async {
    try {
      String idString = ids.join(",");
      QBFilter filter = QBFilter();
      filter.field = QBUsersFilterFields.ID;
      filter.operator = QBUsersFilterOperators.IN;
      filter.value = idString;
      List<QBUser?> users = await QB.users.getUsers(filter: filter);
      List<QBUser> userList = users.whereType<QBUser>().toList();
      return right(userList);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<Object>>> getUsersInDialog(
      {required String dialogId}) async {
    try {
      // Define a filter to find the dialog by its ID
      QBFilter filter = QBFilter();
      filter.field = QBChatDialogFilterFields.ID;
      filter.operator = QBChatDialogFilterOperators.ALL;
      filter.value = dialogId;

      // Fetch dialogs matching the filter
      List<QBDialog?> nullableDialogs = await QB.chat.getDialogs();
      List<QBDialog> dialogs = nullableDialogs.whereType<QBDialog>().toList();
      List<QBDialog> dialogList =
          dialogs.where((dialog) => dialog.id == dialogId).toList();

      if (dialogList.isEmpty) {
        log("No dialog found with the specified ID.");
        return left(AppFailure.badRequest(ErrorMessages().badRequestString));
      }

      // Get the first dialog (since we filtered by dialog ID, there should be only one)
      QBDialog dialog = dialogList.first;

      // Extract the occupants (user IDs) from the dialog
      List<int> occupantIds = dialog.occupantsIds ?? [];

      log("Occupants in dialog: $occupantIds");

      // Check if there are occupants to fetch
      if (occupantIds.isNotEmpty) {
        final result = await getUsersByIds(ids: occupantIds);
        return result.fold(
          (l) => left(l),
          (r) => right(r),
        );
      } else {
        log("No occupants in the dialog.");
        return left(const AppFailure.serverError("No occupants in the dialog"));
      }
    } catch (e) {
      log("Error fetching users in dialog: $e");
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<QBDialog>>> getPrivateDialogs() async {
    try {
      // Define filters for fetching private dialogs (type 3 indicates private dialog)
      List<QBDialog?> dialogs = await QB.chat.getDialogs();
      List<QBDialog> result =
          dialogs.where((dialog) => dialog != null).cast<QBDialog>().toList();

      // Filter only private dialogs (type 3)
      var privateDialogs = result.where((dialog) => dialog.type == 3).toList();

      // var result =
      //     dialogs.where((dialog) => dialog != null).toList() as List<QBDialog>;
      return right(privateDialogs);
    } catch (e) {
      log("Error fetching private dialogs: $e");
      return left(AppFailure.badRequest(ErrorMessages().badRequestString));
    }
  }

  @override
  Future<Either<AppFailure, QBDialog>> getDialogsWithLastMessage(
      {required QBDialog dialog}) async {
    try {
      // for (QBDialog dialog in r) {
      String lastMessage = dialog.lastMessage ?? "No messages yet";
      int? lastMessageTimestamp = dialog.lastMessageDateSent;

      // Convert the timestamp to a readable format
      String formattedTime = lastMessageTimestamp != null
          ? DateTime.fromMillisecondsSinceEpoch(lastMessageTimestamp * 1000)
              .toString()
          : "No timestamp available";

      // Print or display dialog info
      print("Dialog ID: ${dialog.id}");
      print("Last Message: $lastMessage");
      print("Time: $formattedTime");
      dialog.lastMessage = lastMessage;

      // }
      return right(dialog);
    } catch (e) {
      return left(AppFailure.badRequest(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, QBUser>> updateUseDetails(
      {String? fullName,
      String? login,
      String? email,
      String? phone,
      String? age,
      String? city}) async {
    try {
      final failureOrSuccessOption = await QB.users.updateUser(
        login: login,
        fullName: fullName,
        email: email,
        phone: phone,
      );
      if (failureOrSuccessOption != null) {
        return right(failureOrSuccessOption);
      } else {
        return left(AppFailure.badRequest(ErrorMessages().badRequestString));
      }
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> reportMessage(
      {int? reportedUserId, String? reportedContent}) async {
    var payload = {
      "reported_user_id": reportedUserId,
      "report_content": reportedContent
    };
    final failureOrSuccessOption =
        await _httpService.post(payload: payload, path: Paths.reportMessage);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      var result = r.value["message"];
      return right(result);
    });
  }

  @override
  Future<Either<AppFailure, QBDialog?>> searchDialogByName(
      {String? dialogName}) async {
    try {
      QBFilter filter = QBFilter();

      filter.value = dialogName;
      // final filters = {'type': 2, 'name': dialogName}; // 2 for group chat
      final dialogs = await QB.chat.getDialogs(filter: filter);

      if (dialogs.isNotEmpty) {
        final dialog = dialogs.first;
        return right(dialog);
      } else {
        return right(null);
      }

      // return Right(dialogs.isNotEmpty ? dialogs[0] : null);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, QBDialog>> updateDialogOccupants(
      {required String dialogId, required List<int> addUsers}) async {
    try {
      final updatedDailog =
          await QB.chat.updateDialog(dialogId, addUsers: addUsers);
      return right(updatedDailog!);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }
}
