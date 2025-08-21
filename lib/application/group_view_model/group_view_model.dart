import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'dart:js_interop';

// import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/core/constants/error_messages.dart';
import 'package:ofwhich_v2/domain/group/group_service.dart';
import 'package:ofwhich_v2/domain/group/models/chat_sdk_group_model.dart';
import 'package:ofwhich_v2/domain/group/models/group_model.dart';
// import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
// import 'package:ofwhich_v2/infrastructure/chat/qbb_message_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
// import 'package:path/path.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/mappers/qb_message_mapper.dart';
import 'package:quickblox_sdk/models/qb_attachment.dart';
// import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_file.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../domain/chat/chat_service.dart';
// import '../../domain/group/models/member_model.dart';
import '../../infrastructure/handler/snack_bar_handler.dart';
import '../chat_view_model/qb_attachment_model.dart';

@injectable
class GroupViewModel extends BaseViewModel {
  final GroupService groupService;
  final ChatService chatService;
  final SnackbarHandler snackbarHandlerImpl;

  Stream? someStream;

  GroupViewModel(this.snackbarHandlerImpl,
      {required this.groupService, required this.chatService});

  List<GroupModel> groupList = [];
  List<GroupModel> userGroupList = [];

  Future<void> getGroups() async {
    setBusy(true);
    final result = await groupService.getGroups();
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      groupList = r.groups ?? [];
      notifyListeners();
      // log("stufffffff" + groupList.length.toString());
    });
  }

  Future<void> getUserGroup() async {
    setBusy(true);
    final result = await groupService.getUserGroups();
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      userGroupList = r.groups ?? [];
      notifyListeners();
      // log("stufffffff" + groupList.length.toString());
    });
  }

  Future<void> addMembers({required GroupModel groupModel}) async {
    setBusy(true);
    final result = await groupService.addMember(groupId: groupModel.id ?? 0);
    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) async {
      setBusy(false);
      await getCurrentUser();
      // await manageUserInChat(
      //     userid: currentUser?.id ?? 0, dialogId: groupModel.sdk_id ?? "");
      getIt<AppRouter>().push(GroupChatRoute(groupModel: groupModel));
    });
  }

  // String login = "odunayoojomo0@gmail.com";
  // String password = "P@ssw0rd";
  authenticateChateUser(
      {required String login, required String password}) async {
    return (await chatService.authennticateUser(
        login: login, password: password));
  }

  // int userId = 140166913;
  // String cn_password = "superPassword";
  connectToChat({required String login, required String password}) async {
    return (await chatService.connectToChat(
        userId: currentUser!.id.toString(), password: password));
  }

  initializeChat() async {
    return (await chatService.initializeChat());
  }

  // List<int> occupantsIds = [140166913, 140166978];
  // String dialogName = "test dialog";
  int dialogType = QBChatDialogTypes.GROUP_CHAT;
  createPersonalChat({required String dialogName}) async {
    return (await chatService.createPersonalChatDialog(
        occupantsId: [], dialogType: dialogType, chatName: dialogName));
  }

  Future<void> sendMessageQb(
      {required String message, required String dialogId}) async {
    final failureOrSuccessOptionn =
        await chatService.sendMessageQB(dialogId: dialogId, message: message);
    return failureOrSuccessOptionn.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? "Something went wrong");
    }, (r) {
      return;
    });
  }

  subscribeToEvent() {
    return chatService.subScribeToChat();
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
          _messageStreamController.addError(e);
        }
      }, onErrorMethod: (error) {
        _messageStreamController.addError(error);
        // Handle error
        log("Error subscribing to chat event: $error");
      });
      _isSubscribed = true;
      notifyListeners();
    } on PlatformException catch (e) {
      // Handle platform-specific error
      log("PlatformException: ${e.message}");
    }
  }

  bool userIsTyping = false;

  void subscribeToTypingEvents(String dialogId) {
    // Subscribe to "user is typing" events
    QB.chat.subscribeChatEvent(QBChatEvents.USER_IS_TYPING, (data) {
      // `data` should contain user information related to typing
      log('User is typing...');
      userIsTyping = true;
      // Show typing indicator in the UI
    });

    // Subscribe to "user stopped typing" events
    QB.chat.subscribeChatEvent(QBChatEvents.USER_STOPPED_TYPING, (data) {
      // `data` should contain user information related to stopped typing
      log('User stopped typing.');
      userIsTyping = false;
      // Hide typing indicator in the UI
    });
  }

  List<QBMessage> messageList = [];

  Future<void> loadMessages({required String dialogId}) async {
    final failureOrSuccessOption =
        await chatService.getDialogMessages(dialogId: dialogId);
    return failureOrSuccessOption.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      messageList = r as List<QBMessage>;
      _messageStreamController.add(messageList);
      notifyListeners();
    });
  }

  QBUser? currentUser;

  Future<void> getCurrentUser() async {
    final result = await chatService.getQBCurrentUser();
    return result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      currentUser = r as QBUser;
      notifyListeners();
    });
  }

  // Future<void> checkGroupList() async {
  //   List<MiniChatGroupModel> chatList = [];
  //   final result = await groupService.listGroupsWithoutSDK();
  //   return result.fold((l) {
  //     snackbarHandlerImpl
  //         .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
  //   }, (r) async {
  //     List<GroupModel> groupModelList = r;
  //     // await getCurrentUser();
  //     if (groupModelList.isNotEmpty) {
  //       await doSeriousComputation(
  //           groupModelList: groupModelList, chatList: chatList);
  //     } else {
  //       final result = await groupService.getUserGroups();
  //       return result.fold((l) {
  //         return snackbarHandlerImpl.showErrorSnackbar(
  //             l.message ?? ErrorMessages().serverErrorString);
  //       }, (r) async {
  //         await doSeriousComputation(
  //             groupModelList: r.groups!, chatList: chatList);
  //       });
  //     }
  //   });
  // }

  // Future<void> doSeriousComputation(
  //     {required List<GroupModel> groupModelList,
  //     required List<MiniChatGroupModel> chatList}) async {
  //   for (var group in groupModelList) {
  //     final result = await chatService.getAllUserIds();
  //     return result.fold((l) {
  //       snackbarHandlerImpl.showErrorSnackbar(l.message!);
  //     }, (userIds) async {
  //       final dialogSearchResult = await chatService.searchDialogByName(
  //           dialogName: group.name ?? "n/a");
  //       return await dialogSearchResult.fold((l) {
  //         snackbarHandlerImpl.showErrorSnackbar(l.message!);
  //       }, (existingDialog) async {
  //         // final userId = userIds
  //         //     .firstWhere((element) => element == currentUser?.id, orElse: () {
  //         //   return 0;
  //         // });
  //         if (existingDialog != null &&
  //            ! existingDialog.occupantsIds!.toSet().containsAll(userIds)) {
  //           final updateResult = await chatService.updateDialogOccupants(
  //               dialogId: existingDialog.id!, addUsers: [...userIds]);
  //           return updateResult.fold((l) {
  //             snackbarHandlerImpl.showErrorSnackbar(
  //                 l.message ?? ErrorMessages().serverErrorString);
  //           }, (r) {
  //             var model =
  //                 MiniChatGroupModel(id: group.id ?? 0, sdk_id: r.id ?? 'n/a');
  //             chatList.add(model);
  //             updateSDKID(groups: chatList);
  //           });
  //         } else {
  //           final result = await chatService.createPersonalChatDialog(
  //               occupantsId: [...userIds],
  //               chatName: group.name ?? "N/A",
  //               dialogType: QBChatDialogTypes.GROUP_CHAT);

  //           result.fold((l) {
  //             snackbarHandlerImpl.showErrorSnackbar(
  //                 l.message ?? ErrorMessages().serverErrorString);
  //           }, (r) async {
  //             var model = MiniChatGroupModel(id: group.id ?? 0, sdk_id: r);
  //             chatList.add(model);
  //             updateSDKID(groups: chatList);
  //           });
  //         }
  //       });
  //     });
  //   }
  // }

Future<void> checkGroupList() async {
  List<MiniChatGroupModel> chatList = [];
  final result = await groupService.listGroupsWithoutSDK();
  
  return result.fold((l) {
    snackbarHandlerImpl.showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
  }, (r) async {
    List<GroupModel> groupModelList = r;
    if (groupModelList.isNotEmpty) {
      await doSeriousComputation(groupModelList: groupModelList, chatList: chatList);
    } else {
      final result = await groupService.getUserGroups();
      return result.fold(
        (l) => snackbarHandlerImpl.showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString),
        (r) async => await doSeriousComputation(groupModelList: r.groups!, chatList: chatList)
      );
    }
  });
}

Future<void> doSeriousComputation({
  required List<GroupModel> groupModelList,
  required List<MiniChatGroupModel> chatList
}) async {
  for (var group in groupModelList) {
    final result = await chatService.getAllUserIds();
    
    await result.fold((l) {
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (userIds) async {
      final dialogSearchResult = await chatService.searchDialogByName(dialogName: group.name ?? "n/a");
      
      await dialogSearchResult.fold((l) {
        snackbarHandlerImpl.showErrorSnackbar(l.message!);
      }, (existingDialog) async {
        // If dialog exists and users don't match
        if (existingDialog != null) {
          final existingUserSet = existingDialog.occupantsIds!.toSet();
          final newUserSet = userIds.toSet();
          
          // Only update if the sets are different
          if (!existingUserSet.containsAll(newUserSet) || !newUserSet.containsAll(existingUserSet)) {
            final updateResult = await chatService.updateDialogOccupants(
              dialogId: existingDialog.id!,
              addUsers: [...userIds]
            );
            
             updateResult.fold(
              (l) => snackbarHandlerImpl.showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString),
              (r) {
                var model = MiniChatGroupModel(id: group.id ?? 0, sdk_id: r.id ?? 'n/a');
                chatList.add(model);
                updateSDKID(groups: chatList);
              }
            );
          }
          // If users match, do nothing
        } else {
          // If dialog doesn't exist, create new one
          final result = await chatService.createPersonalChatDialog(
            occupantsId: [...userIds],
            chatName: group.name ?? "N/A",
            dialogType: QBChatDialogTypes.GROUP_CHAT
          );
          
           result.fold(
            (l) => snackbarHandlerImpl.showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString),
            (r) {
              var model = MiniChatGroupModel(id: group.id ?? 0, sdk_id: r);
              chatList.add(model);
              updateSDKID(groups: chatList);
            }
          );
        }
      });
    });
  }
}
  int counter = 0;
  manageGroupCreation() async {
    //signout currenntuser
    //sign in admin
    //create groups with admin
    //sign inn user
    await chatService.logOutQBUser();
    final failureOrSuccessOption = await chatService.authennticateUser(
        login: "johndoe@gmail.com", password: "P@ssw0rd");
    failureOrSuccessOption.fold((l) async {
      if (counter > 3) {
        return;
      } else {
        counter++;
        await manageGroupCreation();
      }
    }, (r) async {
      // Future.wait(
      //     [checkGroupList(), chatService.logOutQBUser(), loginSavedQBUser()]);
      // await checkGroupList();
      checkGroupList().then((value) {
        chatService.logOutQBUser().then((value) async {
          await loginSavedQBUser();
        });
      });
      // await chatService.logOutQBUser();
      // await loginSavedQBUser();
    });
  }

  Future<void> loginSavedQBUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString("qbUserLogin") ?? "";
    log("prefs resulttttttt:::::::$result");
    if (result.isNotEmpty) {
      Map<String, dynamic> data = json.decode(result);
      final failureOrSuccessOptionn = await chatService.authennticateUser(
          login: data['email'] ?? "", password: data['password'] ?? "");
      return failureOrSuccessOptionn.fold((l) {}, (r) async {
        await chatService.getQBCurrentUser();
      });
    }
  }

  updateSDKID({required List<MiniChatGroupModel> groups}) async {
    var result = await groupService.updateSDKId(groups: groups);
    result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
      // updateSDKID(groups: groups);
    }, (r) {
      snackbarHandlerImpl.showSnackbar("Success");
      getUserGroup();
      getGroups();
    });
  }

  void sendIsTyping({required String dialogId}) async {
    final result = await chatService.sendIsTyping(dialogId: dialogId);
    return result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {});
  }

  void sendTypingStopped({required String dialogId}) async {
    final result = await chatService.sendIsTypingStopped(dialogId: dialogId);
    return result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {});
  }

  // void sendAttachment({required File file, required String dialogId}) async {
  //   var uploadedFile = await chatService.uploadQBFile(file: file);
  //   uploadedFile.fold((l) {
  //     snackbarHandlerImpl
  //         .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
  //   }, (r) async {
  //     QBFile file = r as QBFile;
  //     if (file.id != null) {
  //       var result = await chatService.sendMessageWithAttachment(
  //           dialogId: dialogId, qbFile: file);
  //       result.fold((l) {
  //         snackbarHandlerImpl.showErrorSnackbar(
  //             l.message ?? ErrorMessages().serverErrorString);
  //       }, (r) {});
  //     }
  //   });
  // }

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

  Future<QBUser> getMatchedUserId(
      {required int? matchedUser, required String dialogId}) async {
    final result = await chatService.getUsersInDialog(dialogId: dialogId);
    return result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
      return QBUser();
    }, (r) {
      List<QBUser> users = r as List<QBUser>;
      // UserModel um= UserModel()
      //* user member email to decide
      // log("users:::::${users[1].email}");
      log("matchedUser :::::${matchedUser!}");
      var result = users.firstWhere((element) => element.id == matchedUser);
      log(result.fullName!);
      return result;
    });
  }
//   Future<List<String?>> fetchAttachmentUrls({
//   required List<QBAttachment?>? attachments,
// }) {
//   if (attachments == null || attachments.isEmpty) {
//     return Future.value([]);
//   }

//   // Create a list of Futures to fetch URLs
//   List<Future<String?>> futures = attachments.map((attachment) {
//     if (attachment != null) {
//       return getFileUrl(fileId: attachment.id ?? "");
//     }
//     return Future.value(null); // Return a completed Future with null if attachment is null
//   }).toList();

//   // Use Future.wait to await all Futures and return the result
//   return Future.wait(futures);
// }

  manageUserInChat({required int userid, required String dialogId}) async {
    final result = await chatService.getDialog(dialogId: dialogId);
    result.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) async {
      List<int> occupantsId = r.occupantsIds ?? [];
      if (occupantsId.contains(userid)) {
        final result = await chatService.joinDialog(dialogId: dialogId);
        result.fold((l) {
          snackbarHandlerImpl.showErrorSnackbar(
              l.message ?? ErrorMessages().serverErrorString);
        }, (r) {});
      } else {
        // final result =
        //     await chatService.updateDialog(userId: userid, dialogId: dialogId);
        // return result.fold((l) {
        //   snackbarHandlerImpl.showErrorSnackbar(
        //       l.message ?? ErrorMessages().serverErrorString);
        // }, (r) {});
      }
    });
  }

  void sendAttachment(
      {required File file,
      required String dialogId,
      String? fileType,
      VoidCallback? done}) async {
    var uploadedFile = await chatService.uploadQBFile(file: file);
    uploadedFile.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) async {
      QBFile file = r as QBFile;
      if (file.id != null) {
        var result = await chatService.sendMessageWithAttachment(
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

  @override
  void dispose() {
    super.dispose();
    _messageStreamController.close(); // Dispose the stream controller when done
  }
}
