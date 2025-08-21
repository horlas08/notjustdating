// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ofwhich_v2/domain/core/constants/error_messages.dart';
import 'package:ofwhich_v2/domain/group/models/member_model.dart';
import 'package:ofwhich_v2/domain/user_service/model/data_fetch_model.dart';
import 'package:ofwhich_v2/domain/user_service/model/date_request_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/mappers/qb_message_mapper.dart';
import 'package:quickblox_sdk/models/qb_attachment.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_file.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/chat/chat_service.dart';
import 'package:ofwhich_v2/domain/user_service/model/firebase_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

import '../../domain/auth/i_auth_facade.dart';
import '../../domain/user_service/model/date_model.dart';
import '../../domain/user_service/model/user_object.dart';
import '../../domain/user_service/user_service.dart';
import '../../infrastructure/handler/snack_bar_handler.dart';
import '../../presentation/routes/app_router.gr.dart';
import '../profile/profile_view_model.dart';
import 'qb_attachment_model.dart';

@LazySingleton()
class ChatViewModel extends ChangeNotifier {
  final ChatService _chatService;
  final IAuthFacade authFacade;
  final UserService userService;
  final SnackbarHandler snackbarHandlerImpl;

  List<UserFromFirestore> users = [];
  late AudioRecorder audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  bool isRecordingDone = false;
  String audioPath = "";

  ChatViewModel(this._chatService, this.authFacade, this.userService,
      this.snackbarHandlerImpl);

  List<UserModel> matchedUsers = [];
  bool isBusy = false;

  sendMessage({required String receiverId, required String message}) async {
    await _chatService.sendMessage(receiverId: receiverId, message: message);
  }

  Stream<QuerySnapshot> getMessages(
      {required String? userId, required String otherUserId}) {
    return _chatService.getMessages(
        userId: userId ?? "", otherUserId: otherUserId);
  }

  UserModel? user;
  // UserModel user => _chatService.getSavedUser();

  setBusy(val) {
    isBusy = val;
    notifyListeners();
  }

  getSavedUaser() async {
    user = await _chatService.getSavedUser();
    notifyListeners();
  }

  getFirebaseUsers() async {
    setBusy(true);
    final result = await userService.getUsers();
    return result.fold((l) {
      log(l.message ?? "empty");
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      users = r;
      notifyListeners();
    });
  }

  Future<void> uploadImage(
      {required File file,
      required String receiverId,
      required String message}) async {
    setBusy(true);
    final result = await _chatService.uploadFile(file: file);
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      snackbarHandlerImpl.showSnackbar(r);
      sendMessage(receiverId: receiverId, message: "$r   $message");
    });
  }

  ///* record methods*//
  bool playing = false;
  Future<void> startRecording() async {
    final Directory tempDir = await getTemporaryDirectory();
    var uuid = const Uuid();
    final fileName = "${uuid.v1()}.m4v"; //
    try {
      log("START RECODING+++++++++++++++++++++++++++++++++++++++++++++++++");
      if (await audioRecord.hasPermission()) {
        await audioRecord.start(const RecordConfig(),
            path: '${tempDir.path}/$fileName');
        // setState(() {
        isRecording = true;
        notifyListeners();
        // });
      }
    } catch (e, stackTrace) {
      log("START RECODING+++++++++++++++++++++$e++++++++++$stackTrace+++++++++++++++++");
    }
  }

  Future<String> getPath() async {
    final Directory tempDir = await getTemporaryDirectory();
    var uuid = const Uuid();
    final fileName = "${uuid.v1()}.m4v";
    return '${tempDir.path}/$fileName';
  }

  getMatchedUsers() async {
    setBusy(true);
    final result = await userService.getMatchedUserList();
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      matchedUsers = r;
      notifyListeners();
    });
  }

  authenticateChateUser(
      {required String login, required String password}) async {
    return (await _chatService.authennticateUser(
        login: login, password: password));
  }

  // int userId = 140166913;
  // String cn_password = "superPassword";
  connectToChat({required String login, required String password}) async {
    return (await _chatService.connectToChat(
        userId: currentUser!.id.toString(), password: password));
  }

  initializeChat() async {
    return (await _chatService.initializeChat());
  }

  // List<int> occupantsIds = [140166913, 140166978];
  // String dialogName = "test dialog";

  createPersonalChat({required String dialogName}) async {
    return (await _chatService.createPersonalChatDialog(
        occupantsId: [], dialogType: dialogType, chatName: dialogName));
  }

  Future<void> sendMessageQb(
      {required String message, required String dialogId}) async {
    final failureOrSuccessOptionn = await _chatService.sendMessageQBPrivateChat(
        dialogId: dialogId, message: message);
    return failureOrSuccessOptionn.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? "Something went wrong");
    }, (r) {
      return;
    });
  }

  subscribeToEvent() {
    return _chatService.subScribeToChat();
    // notifyListeners();
  }

  final StreamController<List<QBMessage>> _messageStreamController =
      StreamController<List<QBMessage>>.broadcast();

  Stream<List<QBMessage>> get messageStream => _messageStreamController.stream;
  bool _isSubscribed = false;

  Future<void> subscribeNewMessage() async {
    String eventName = QBChatEvents.RECEIVED_NEW_MESSAGE;
    log('Subscribed function called');
    try {
      if (_isSubscribed) {
        log("Already subscribed to new message events.");
        return;
      }
      await QB.chat.subscribeChatEvent(eventName, (data) {
        log("Received data: $data");
        try {
          Map<String, dynamic> map = Map<String, dynamic>.from(data);
          Map<String, dynamic> payload =
              Map<String, dynamic>.from(map["payload"]);
          log("Payload data: ${payload.toString()}");
          QBMessage model =
              QBMessageMapper.mapToQBMessage(payload) ?? QBMessage();
          messageList.add(model);
          log("message list :${messageList.length}");
          _messageStreamController.add(messageList);

          notifyListeners(); // Add payload to the stream
        } catch (e) {
          log("Error parsing data: $e");
          _messageStreamController.addError(e); // Add error to stream
        }
      }, onErrorMethod: (error) {
        _messageStreamController.addError(error); // Add error to stream
        // Handle error
        log("Error subscribing to chat event: $error");
      });
      _isSubscribed = true;
      notifyListeners();
    } on PlatformException catch (e) {
      // Handle platform-specific error
      _messageStreamController.addError(e); // Corrected error variable here
      log("PlatformException: ${e.message}");
    }
  }

  bool userIsTyping = false;

  final StreamController<bool> _typingController =
      StreamController<bool>.broadcast();

  // Expose a stream for listening to typing events
  Stream<bool> get typingStream => _typingController.stream;

  // Function to subscribe to typing events
  void subscribeToTypingEvents(String dialogId) {
    // Subscribe to "user is typing" events
    QB.chat.subscribeChatEvent(QBChatEvents.USER_IS_TYPING, (data) {
      log('User is typing...');
      userIsTyping = true;

      // Add the typing event to the stream
      _typingController.sink.add(true);
    });

    // Subscribe to "user stopped typing" events
    QB.chat.subscribeChatEvent(QBChatEvents.USER_STOPPED_TYPING, (data) {
      log('User stopped typing.');
      userIsTyping = false;

      // Add the stop typing event to the stream
      _typingController.sink.add(false);
    });
  }

  List<QBMessage> messageList = [];

  Future<void> loadMessages({required String dialogId}) async {
    final failureOrSuccessOption =
        await _chatService.getDialogMessages(dialogId: dialogId);
    return failureOrSuccessOption.fold((l) {
      snackbarHandlerImpl.showErrorSnackbar(ErrorMessages().serverErrorString);
    }, (r) {
      messageList = r as List<QBMessage>;
      _messageStreamController.add(messageList);
      notifyListeners();
    });
  }

  QBUser? currentUser;

  Future<void> getCurrentUser() async {
    final result = await _chatService.getQBCurrentUser();
    return result.fold((l) {
      snackbarHandlerImpl.showErrorSnackbar(ErrorMessages().serverErrorString);
    }, (r) {
      currentUser = r as QBUser;
      notifyListeners();
    });
  }

  void sendIsTyping({required String dialogId}) async {
    final result = await _chatService.sendIsTyping(dialogId: dialogId);
    log(result.toString());
    return result.fold((l) {
      snackbarHandlerImpl.showErrorSnackbar(ErrorMessages().serverErrorString);
    }, (r) {});
  }

  void sendTypingStopped({required String dialogId}) async {
    final result = await _chatService.sendIsTypingStopped(dialogId: dialogId);
    log(result.toString());
    return result.fold((l) {
      snackbarHandlerImpl.showErrorSnackbar(ErrorMessages().serverErrorString);
    }, (r) {});
  }

  void sendAttachment(
      {required File file,
      required String dialogId,
      String? fileType,
      VoidCallback? done}) async {
    var uploadedFile = await _chatService.uploadQBFile(file: file);
    uploadedFile.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) async {
      QBFile file = r as QBFile;
      if (file.id != null) {
        var result = await _chatService.sendMessageWithAttachment(
            fileType: fileType, dialogId: dialogId, qbFile: file);
        result.fold((l) {
          snackbarHandlerImpl.showErrorSnackbar(
              l.message ?? ErrorMessages().serverErrorString);
        }, (r) {
          done?.call();
        });
      }
    });
  }

  bool isFileLoadingDone = false;
  Future<String?> getFileUrl({required String fileId}) async {
    isFileLoadingDone = false;
    // notifyListeners();
    var qbFile = await QB.content.getPrivateURL(fileId);
    isFileLoadingDone = true;
    // notifyListeners();
    return qbFile;
  }

  Future<List<QBAttachmentModel>> fetchAttachmentUrls({
    required List<QBAttachment?>? attachments,
  }) async {
    // Early return if attachments are null or empty
    if (attachments == null || attachments.isEmpty) {
      return [];
    }

    List<QBAttachmentModel> contentData = [];

    // Fetch URLs asynchronously
    await Future.wait(
      attachments
          .where((attachment) => attachment != null)
          .map((attachment) async {
        try {
          // Ensure attachment is not null, already filtered out but adding safety
          if (attachment != null && attachment.id != null) {
            // Fetch the URL using the attachment ID
            String? url = await getFileUrl(fileId: attachment.id!);

            // Create QBAttachmentModel if URL is not null
            log("eattachmant::::::${attachment.contentType}");
            if (url != null) {
              contentData.add(
                QBAttachmentModel(
                  url: url,
                  contextType: attachment.type ?? "",
                ),
              );
            }
          }
        } catch (e) {
          // Handle any errors, e.g., log them
          log('Error fetching URL for attachment: ${attachment?.id} - $e');
        }
      }).toList(),
    );

    return contentData;
  }

  getUserSavedLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = prefs.getString("user") ?? "";
    if (userString != "") {
      user = UserModel.fromMap(json.decode(userString));
      // log(user!.toMap().toString());
      notifyListeners();
    }
  }

  int dialogType = QBChatDialogTypes.CHAT;
  String dialogId = "";

// demoFunction()async{
//   QB.chat.
// }
  manageChat({required UserModel matchedUserId, Function(String)? done}) async {
    var ids = [matchedUserId.id, user?.id!];
    List<int> nonNullableList = ids.whereType<int>().toList();
    final result = await _chatService.getChatHistoryWithParticularUser(
        userId: nonNullableList);
    return result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) async {
      if (r.isNotEmpty) {
        done?.call(r[0].toString());
        final result = await _chatService.joinDialog(dialogId: r[0].toString());
        return result.fold((l) {
          snackbarHandlerImpl.showErrorSnackbar(
              l.message ?? ErrorMessages().serverErrorString);
        }, (r) {});
        //join chat
        // final result = await _chatService.st
      } else {
        final result = await _chatService.fetchUserbyEmailOrLogin(
            login: matchedUserId.email ?? "N/A",
            email: matchedUserId.email ?? "N/A");
        return result.fold((l) {
          snackbarHandlerImpl.showErrorSnackbar(
              l.message ?? ErrorMessages().serverErrorString);
        }, (r) async {
          var listResult = r
              .where((element) => element.email!.contains(matchedUserId.email!))
              .toList();
          var occupantsId = [listResult[0].id, currentUser?.id ?? 0];
          List<int> nonNullableList2 = occupantsId.whereType<int>().toList();
          var chatName = "${listResult[0].fullName}/${currentUser?.fullName}";
          final result = await _chatService.createPersonalChatDialog(
              occupantsId: nonNullableList2,
              chatName: chatName,
              dialogType: dialogType);
          return result.fold((l) {}, (r) {
            //todo:temporary fix
            dialogId = r;
            notifyListeners();
            done?.call(dialogId.toString());
            sendSdkIdForPersonalChat(sdkId: r, userIds: nonNullableList);
          });
        });
      }
    });
  }

  Future<void> sendSdkIdForPersonalChat(
      {required List<int> userIds, required String sdkId}) async {
    final result = await _chatService.storeSdkChatHistory(
        usersIds: userIds, sdkChatId: sdkId);
    return result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {});
  }

  // updateDilaog() async {
  //   return _chatService.updateDialog(
  //       userId: 0122334, dialogId: "66db7a6fe529b922621bc95b");
  // }

  Future<bool> checkUserPresence({required int userId}) async {
    final result = await _chatService.pingUser(userId: userId);
    return result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
      return false;
    }, (r) {
      return r;
    });
  }

  Future<QBUser> getMatchedUserId(
      {required UserModel matchedUser, required String dialogId}) async {
    final result = await _chatService.getUsersInDialog(dialogId: dialogId);
    return result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
      return QBUser();
    }, (r) {
      List<QBUser> users = r as List<QBUser>;

      var result =
          users.firstWhere((element) => element.email == matchedUser.email);
      return result;
    });
  }

  Future<void> reportMessage(
      {required int reportedUserId, required String reportedContent}) async {
    setBusy(true);

    final result = await _chatService.reportMessage(
        reportedUserId: reportedUserId, reportedContent: reportedContent);

    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      setBusy(false);
      snackbarHandlerImpl.showSnackbar(r);
    });
  }

  // Map<int, bool> userPresenceStatus = {};

  // void initializePresenceUpdates() async {
  //   try {
  //     // Subscribe to presence events
  //     await QB.chat.subscribeChatEvent(QBChatEvents.RECEIVED_PRESENCE, (data) {
  //       handlePresenceUpdate(data);
  //     }, onErrorMethod: (error) {
  //       log("Error subscribing to presence events: $error");
  //     });
  //   } catch (e) {
  //     log("Error initializing presence updates: $e");
  //   }
  // }

  // void handlePresenceUpdate(dynamic data) {
  //   try {
  //     Map<String, dynamic> presenceData = Map<String, dynamic>.from(data);
  //     String status = presenceData['status'] as String; // Online/Offline status
  //     int userId = presenceData['userId']; // User ID

  //     // Determine online status based on the presence type
  //     bool isOnline = status == "online" || status == "available";

  //     // Update the map with the user's status
  //     userPresenceStatus[userId] = isOnline;

  //     print('User $userId is ${isOnline ? 'online' : 'offline'}.');
  //   } catch (e) {
  //     print("Error processing presence update: $e");
  //   }
  // }

  List<QBDialog> dialogs = [];
  void fetchDialogs() async {
    final result = await _chatService.getPrivateDialogs();
    return result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) async {
      dialogs = r;
      log("dialogs::::$dialogs");
      notifyListeners();
      // for (var dialog in dialogs) {
      //   final failureOrSuccessOption =
      //       await _chatService.getDialogsWithLastMessage(dialog: dialog);
      //   return failureOrSuccessOption.fold((l) {}, (r) {});
      // }
    });
  }

  UserModel getMatchedUser(
      {required List<UserModel> matchedUsers, required fullName}) {
    var result = matchedUsers.firstWhere(
        (element) => element.email == fullName || element.username == fullName);
    return result;
  }

  MemberModel getUserByUsername(
      {required List<MemberModel> matchedUsers, required String email}) {
    var result = matchedUsers.firstWhere((element) => element.email == email);
    log(result.toString());
    return result;
  }

  void planDate(
      {List<num>? locations,
      String? budget,
      List<DateModel>? dates,
      String? type,
      num? dateUserId,
      num? dateId,
      String? payment_method}) async {
    setBusy(true);
    await getIt<ProfileViewModel>().getUserSavedLocally();
    DateRequestModel dateReq = DateRequestModel(
        request_initiator_type: type ?? "requester",
        budget: budget ?? "N5,000-N10,000",
        payment_method: payment_method!,
        requestType: type,
        // requested_id: getIt<ProfileViewModel>().user?.id ?? 0,
        locations: locations ?? [],
        availability_options: dates!);
    // userService.getUserProfile()

    var result = await userService.sendDateRequest(
        dateReq: dateReq,
        type: type!,
        requestedId: dateUserId,
        request_id: dateId);
    return result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      getIt<AppRouter>().push(
          DatePaymentWebViewPage(paymentData: r, paymentInitiatorType: type));
      snackbarHandlerImpl.showSnackbar("Date request sent successfully");
      getDateRequests();
      getMatchedUsers();
    });
  }

  List<DateFetchModel> dateFetch = [];

  getDateRequests({String filter = "requested"}) async {
    setBusy(true);
    var result = await userService.fetchDataRequests(filter: "requested");
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      setBusy(false);
      dateFetch = r.where((e) => e.status != "rejected").toList();
      notifyListeners();
    });
  }

  upatePayment({required String type, required String ref}) async {
    setBusy(true);
    var result = await userService.updateDateRequestPayment(
        reference_id: ref, payment_initiator_type: type);
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      setBusy(false);
      getDateRequests();
      getMatchedUsers();
      snackbarHandlerImpl.showSnackbar(r);
    });
  }

  rejectDateRequest({
    num? dateId,
  }) async {
    setBusy(true);

    var result = await userService.rejectDateRequest(request_id: dateId);
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      setBusy(false);
      snackbarHandlerImpl.showSnackbar("Rejected successfully");
      getDateRequests();
      getMatchedUsers();
      // getMatchedUser(matchedUsers: matchedUsers, fullName: fullName)
    });
  }
}
