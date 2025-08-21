// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_emoji_picker/keyboard_emoji_picker.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/utils/util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
// import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:stacked/stacked.dart';

import '../../application/chat_view_model/chat_view_model.dart';
import '../../application/chat_view_model/qb_attachment_model.dart';
import '../../application/group_view_model/group_view_model.dart';
import '../../domain/group/models/group_model.dart';
import '../../domain/group/models/member_model.dart';
// import '../../domain/user_service/model/user_object.dart';
import '../chat/widgets/chat_app_bar.dart';
import '../chat/widgets/chat_bubble.dart';
import '../core/font.dart';
import '../general_widgets/app_audio_player.dart';
import '../general_widgets/custom_textfield.dart';
import '../general_widgets/report_modal.dart';
// import '../routes/app_router.dart';

@RoutePage()
class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key, required this.groupModel});
  final GroupModel groupModel;
  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  TextEditingController controller = TextEditingController();
  RecorderController recordController = RecorderController();
  String path = "";
  final ScrollController _scrollController = ScrollController();
  bool _isRecording = false;
  String? _audioPath;
  bool isPlaying = false;
  bool _isSending = false;

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  Future<void> _initializeRecorder() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
  }

  Future<void> _startRecording() async {
    await _recorder.startRecorder(toFile: 'audio_record.aac');
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    _audioPath = await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
    // print("Recording saved at: $_audioPath");
  }

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
    _controller = AnimationController(vsync: this);
    // log(widget.userId);
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _controller.dispose();
    super.dispose();
  }
  // String dialogId = "66be8e4ec7afcf62f9fbb6e0";

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        // Only scroll to bottom if the current position is not already near the bottom
        final bottomPosition = _scrollController.position.maxScrollExtent;
        final currentScrollPosition = _scrollController.position.pixels;

        // Check if already near bottom to prevent unnecessary jumps
        if (currentScrollPosition < bottomPosition) {
          _scrollController.animateTo(
            bottomPosition,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    // bool isKeyboardOpen = bottomInsets != 0;

    return ViewModelBuilder<GroupViewModel>.reactive(
      onViewModelReady: (c) async {
        // await c.initializeChat();
        // await c.authenticateChateUser();

        // await c.getCurrentUser();
      },
      viewModelBuilder: () => getIt<GroupViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: ChatAppBar(
            child: Row(children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
              ),
              SizedBox(width: 6.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.groupModel.name ?? 'N/A',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: Font.inter)),
                  Text(widget.groupModel.description ?? "N/A",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFFA4A4A4),
                          fontWeight: FontWeight.w400,
                          fontFamily: Font.inter))
                ],
              )
            ]),
          ),
          body: KeyboardEmojiPickerWrapper(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<List<QBMessage>>(
                      stream: model.messageStream,
                      builder: (context, snapshot) {
                        log('StreamBuilder state: ${snapshot.connectionState}');
                        log('Has data: ${snapshot.hasData}');
                        log('Error: ${snapshot.hasError}');
                        log('Message count: ${snapshot.data?.length ?? 0}');

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          // Display the error message
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No messages yet.'));
                        }

                        final messages = snapshot.data!;

                        // Prefetch attachment URLs for all messages
                        Future<List<QBAttachmentModel>> fetchAttachments(
                            QBMessage message) async {
                          List<QBAttachmentModel?> attachmentModels =
                              await model.fetchAttachmentUrls(
                            attachments: message.attachments,
                          );

                          // Filter out any null values
                          // log("attchmetnntssss:::::::::" +
                          //     attachmentModels.toList().toString());
                          return attachmentModels
                              .where((attachment) => attachment != null)
                              .cast<QBAttachmentModel>()
                              .toList();
                        }

                        return FutureBuilder<List<List<QBAttachmentModel>>>(
                          future: Future.wait(
                              messages.map((msg) => fetchAttachments(msg))),
                          builder: (context, attachmentSnapshot) {
                            if (attachmentSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (attachmentSnapshot.hasError) {
                              return Center(
                                  child: Text(
                                      'Error: ${attachmentSnapshot.error}'));
                            } else if (!attachmentSnapshot.hasData ||
                                attachmentSnapshot.data!.isEmpty) {
                              return ListView.builder(
                                controller: _scrollController,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  final message = messages[index];
                                  // widget.groupModel.me
                                  return ChatBubble(
                                    fetchUserById: model.getMatchedUserId,
                                    model: model,
                                    message: message,
                                    dialogId: widget.groupModel.sdk_id,
                                    members: widget.groupModel.members,
                                    urls: [],
                                  );
                                },
                              );
                            }

                            final attachmentUrlsList = attachmentSnapshot.data!;

                            // Defer scroll to bottom to ensure that the UI updates first
                            SchedulerBinding.instance
                                .addPostFrameCallback((_) => _scrollToBottom());

                            return ListView.builder(
                              controller: _scrollController,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                final attachmentUrls =
                                    attachmentUrlsList[index];
                                log("message details::::${message.senderId}");
                                return ChatBubble(
                                  message: message,
                                  urls: attachmentUrls,
                                  fetchUserById: model.getMatchedUserId,
                                  model: model,
                                  members: widget.groupModel.members,
                                  dialogId: widget.groupModel.sdk_id,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Expanded(
                  //   child: Container(
                  //     child: model.user == null
                  //         ? Container()
                  //         : buildMessageList(model),
                  //   ),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      // border: const Border(color: Colors.transparent),
                      border:
                          Border.all(color: Colors.transparent, width: 0.4.w),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _audioPath != null
                              ? AppAudioPlayer(
                                  audioPath: _audioPath!,
                                  onChanged: (val) {
                                    setState(() {
                                      isPlaying = val;
                                    });
                                  },
                                )
                              : CustomTextFieldWidget(
                                  controller: controller,
                                  onChanged: (val) {
                                    if (val.isNotEmpty) {
                                      model.sendIsTyping(
                                          dialogId: widget.groupModel.sdk_id ??
                                              "66be8e4ec7afcf62f9fbb6e0");
                                    } else {
                                      model.sendTypingStopped(
                                          dialogId: widget.groupModel.sdk_id ??
                                              "66be8e4ec7afcf62f9fbb6e0");
                                    }
                                  },
                                  onTap: () {
                                    // isKeyboardOpen
                                    //     ? model.sendIsTyping(
                                    //         dialogId: widget.groupModel.sdk_id ??
                                    //             "66be8e4ec7afcf62f9fbb6e0")
                                    //     : model.sendTypingStopped(
                                    //         dialogId: widget.groupModel.sdk_id ??
                                    //             "66be8e4ec7afcf62f9fbb6e0");
                                  },
                                  filled: true,
                                  fillColor: const Color(0XFFF5F6FC),
                                  hintText: "Type a message",
                                  hintStyle: TextStyle(
                                      fontSize: 16.sp,
                                      color: const Color(0xFF888888)),
                                  suffix: Transform.scale(
                                    scale: 0.7,
                                    child: Image.asset(
                                        "assets/images/pngs/emojies_large.png"),
                                  ),
                                  suffixAction: () async {
                                    final hasEmojiKeyboard =
                                        await KeyboardEmojiPicker()
                                            .checkHasEmojiKeyboard();

                                    if (hasEmojiKeyboard) {
                                      // Open the emoji keyboard and get the selected emoji.
                                      var result = await KeyboardEmojiPicker()
                                          .pickEmoji();

                                      if (result != null && result.isNotEmpty) {
                                        // Append the selected emoji to the text field's controller.
                                        controller.text += result;
                                      }
                                    } else {
                                      // Handle the case where the device doesn't have an emoji keyboard.
                                      // You could show a dialog asking the user to enable the emoji keyboard or
                                      // use another way to pick an emoji, like a custom emoji picker dialog.
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                "Emoji Keyboard Not Found",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontFamily: Font.inter)),
                                            content: Text(
                                                "Please enable your emoji keyboard in settings.",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontFamily: Font.inter)),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text("OK"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }),

                          // ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0.w,
                                              vertical: 20.w),
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.17,
                                            child: Column(
                                              children: [
                                                InkResponse(
                                                  onTap: () async {
                                                    File selectedPhoto =
                                                        await getIt<
                                                                ProfileViewModel>()
                                                            .selextImage(
                                                                type: "camera");
                                                    if (mounted) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                    model.sendAttachment(
                                                        file: selectedPhoto,
                                                        dialogId: widget
                                                                .groupModel
                                                                .sdk_id ??
                                                            "66be8e4ec7afcf62f9fbb6e0");
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/pngs/camera_icon.png",
                                                        scale: 1.5,
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        "Open camera",
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                Font.inter,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                                SizedBox(
                                                    height: 10.h,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: const Divider()),
                                                SizedBox(height: 20.h),
                                                InkResponse(
                                                  onTap: () async {
                                                    File selectedPhoto =
                                                        await getIt<
                                                                ProfileViewModel>()
                                                            .selextImage(
                                                                type:
                                                                    "gallery");
                                                    if (mounted) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                    model.sendAttachment(
                                                        file: selectedPhoto,
                                                        dialogId: widget
                                                                .groupModel
                                                                .sdk_id ??
                                                            "66be8e4ec7afcf62f9fbb6e0");
                                                    // getIt<AppRouter>().push(
                                                    //     FileUploadRoute(
                                                    //         selectedPhoto:
                                                    //             selectedPhoto,
                                                    //         userId: widget.userId));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/pngs/gallery_icon.png",
                                                        scale: 1.5,
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        "Choose from gallery",
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                Font.inter,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: SvgPicture.asset(
                                    "assets/images/svgs/attachment.svg"),
                              ),
                              GestureDetector(
                                onLongPress: _startRecording,
                                onLongPressUp: _stopRecording,
                                child: Icon(Icons.mic,
                                    size: 30.h,
                                    color: _isRecording
                                        ? Colors.red
                                        : Colors.black),
                              ),
                              InkResponse(
                                onTap: () async {
                                  _audioPath == null
                                      ? model.sendMessageQb(
                                          message: controller.text,
                                          dialogId: widget.groupModel.sdk_id ??
                                              "66be8e4ec7afcf62f9fbb6e0")
                                      : setState(() {
                                          _isSending =
                                              true; // Start sending the attachment
                                        });
                                  model.sendAttachment(
                                    done: () {
                                      setState(() {
                                        _audioPath =
                                            null; // Clear the audio path
                                        _isSending =
                                            false; // Mark sending as complete
                                        log("Attachment sent successfully, audio player removed.");
                                      });
                                    },
                                    fileType: "audio",
                                    file: File(_audioPath!),
                                    dialogId: widget.groupModel.sdk_id ?? "",
                                  );

                                  // model.sendAttachment(
                                  //     done: () {
                                  //       setState(() {
                                  //         _audioPath == null;
                                  //       });
                                  //       WidgetsBinding.instance
                                  //           .addPostFrameCallback((_) {
                                  //         setState(() {}); // Force rebuild
                                  //       });
                                  //     },
                                  //     fileType: "audio",
                                  //     file: File(_audioPath!),
                                  //     dialogId:
                                  //         widget.groupModel.sdk_id ?? "");

                                  // _scrollToBottom();

                                  controller.clear();
                                },
                                child: SvgPicture.asset(
                                    "assets/images/svgs/send_icon.svg"),
                              ),
                            ],
                          ),
                        )
                        // IconButton(
                        //     onPressed: () {
                        //       model.sendMessage(
                        //           receiverId: widget.userId,
                        //           message: controller.text);
                        //     },
                        //     icon: Icon(Icons.arrow_upward))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          )),
    );
  }
}

void _showMessageOptions(BuildContext context, String message,
    {VoidCallback? report, VoidCallback? copy}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.copy),
            title: Text('Copy'),
            onTap: () {
              copy?.call();
              Navigator.pop(context);
              // // Handle copy action
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text('Message copied!')),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.reply),
            title: Text('Report'),
            onTap: () {
              report?.call();
              // getIt<ChatViewModel>().reportMessage(reportedUserId: reportedUserId, reportedContent: reportedContent)
              Navigator.pop(context);
              // Handle reply action
            },
          ),
        ],
      );
    },
  );
}

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.model,
    required this.fetchUserById,
    this.members,
    this.dialogId,
    this.urls,
  });

  final QBMessage message;
  final GroupViewModel model;
  final List<QBAttachmentModel>? urls;
  final List<MemberModel>? members;
  final String? dialogId;
  final Future<QBUser?> Function(
      {required int? matchedUser, required String dialogId}) fetchUserById;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  String userEmail = '';
  String sennderEmail = '';
  String receiverEmail = "";
  String senderUsername = "";
  String currentUsername = "";
  @override
  void initState() {
    // sender = widget.getQBUser.call(widget.message.senderId ?? 0);
    // receiver = widget.getQBUser.call(widget.model.currentUser?.id ?? 0);

    super.initState();
    _getUserEmail();
    _getUserDetails();
  }

  Future<void> _getUserEmail() async {
    final int senderId = widget.message.senderId ?? 0;
    final int currentUserId = widget.model.currentUser?.id ?? 0;

    QBUser? targetUser;

    if (senderId == currentUserId) {
      targetUser = widget.model.currentUser;
    } else if (senderId != 0) {
      targetUser = await widget.fetchUserById(
          matchedUser: senderId, dialogId: widget.dialogId!);
    }

    userEmail = targetUser?.email ?? 'Unknown';
    sennderEmail = targetUser?.email ?? 'Unknown';

    log("User email: $userEmail");
    log("Sender email: $sennderEmail");
  }

  Future<void> _getUserDetails() async {
    final int senderId = widget.message.senderId ?? 0;
    final int currentUserId = widget.model.currentUser?.id ?? 0;

    try {
      QBUser? senderUser;
      QBUser? currentUser;

      // Handle current user
      if (senderId == currentUserId) {
        currentUser = QBUser()
          ..id = currentUserId
          ..fullName = widget.model.currentUser?.fullName ?? 'You';
        senderUser = currentUser;
      } else {
        // Fetch current user details
        currentUser = QBUser()
          ..id = currentUserId
          ..fullName = widget.model.currentUser?.fullName ?? 'You';

        // Fetch sender user details
        if (senderId != 0) {
          senderUser = await widget.fetchUserById(
              matchedUser: senderId, dialogId: widget.dialogId!);
        }
      }

      // Set usernames for display
      currentUsername = currentUser.fullName ?? 'Current User';

      if (senderUser != null) {
        senderUsername = senderUser.fullName ?? 'Unknown User';
      }

      // Optional: Log for debugging
      log('Current Username: $currentUsername');
      log('Sender Username: $senderUsername');
    } catch (e) {
      // Error handling
      log('Error fetching user details: $e');
      currentUsername = 'Current User';
      senderUsername = 'Unknown User';
    }
  }

  Future<String> _getUsernameForMessage() async {
    final int senderId = widget.message.senderId ?? 0;
    final int currentUserId = widget.model.currentUser?.id ?? 0;

    // If message is from current user
    if (senderId == currentUserId) {
      return widget.model.currentUser?.fullName ?? 'You';
    }

    // If message is from another user
    try {
      final matchedUser = await widget.fetchUserById(
          matchedUser: senderId, dialogId: widget.dialogId!);

      return matchedUser?.fullName ?? 'Unknown User';
    } catch (e) {
      log('Error fetching username: $e');
      return 'Unknown User';
    }
  }
  // Future<void> _getUserEmail() async {
  //   final int senderId = widget.message.senderId ?? 0;
  //   final int currentUserId = widget.model.currentUser?.id ?? 0;

  //   // Check if the message is from the current user
  //   if (senderId == currentUserId) {
  //     // Show current user's email

  //     userEmail = widget.model.currentUser?.fullName ?? 'Unknown';
  //     sennderEmail = widget.model.currentUser?.fullName ?? "johndoe@gmail.com";
  //     log("current user sideeee:::::" + sennderEmail);
  //   } else if (senderId != 0) {
  //     // Fetch the sender's email if it is not the current user
  //     // for (var member in widget.members!) {
  //     final user = await widget.fetchUserById(
  //         matchedUser: senderId, dialogId: widget.dialogId!);

  //     userEmail = user?.fullName ?? 'Unknown';
  //     sennderEmail = user?.fullName ?? "johndoe@gmail.com";
  //     log("sender sideeee:::::" + sennderEmail);
  //     // }
  //   } else {
  //     final user = await widget.fetchUserById(
  //         matchedUser: senderId, dialogId: widget.dialogId!);

  //     userEmail = user?.fullName ?? 'Unknown';
  //     sennderEmail = user?.fullName ?? "johndoe@gmail.com";
  //     log("sender sideeee:::::" + sennderEmail);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var alignment = (widget.message.senderId == widget.model.currentUser!.id!)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => getIt<ChatViewModel>(),
      builder: (context, model, child) => GestureDetector(
        onLongPress: () {
          _showMessageOptions(context, widget.message.body!, report: () {
            showBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                builder: (
                  context,
                ) {
                  return ReportModal(
                    showBlockButton: false,
                    userId: model
                            .getUserByUsername(
                                matchedUsers: widget.members!,
                                email: sennderEmail)
                            .id
                            .toString() ??
                        "1",
                  );
                });
            // getIt<ChatViewModel>().reportMessage(
            //     reportedUserId: model
            //             .getUserByUsername(
            //                 matchedUsers: widget.members!, email: sennderEmail)
            //             .id ??
            //         1,
            //     reportedContent: widget.message.body ?? "");
          });
        },
        child: Container(
          alignment: alignment,
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:
                  (widget.message.senderId == widget.model.currentUser!.id!)
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                // Text(
                //   currentUsername,
                //   // widget.message.senderId.toString(),
                //   style: TextStyle(fontSize: 12.sp, fontFamily: Font.inter),
                // ),
                FutureBuilder<String>(
                  future: _getUsernameForMessage(),
                  builder: (context, snapshot) {
                    final username = snapshot.data ?? 'Loading...';

                    return Text(
                      username,
                      style: TextStyle(fontSize: 12.sp, fontFamily: Font.inter),
                    );
                  },
                ),

                const SizedBox(height: 5),
                if (widget.urls != null && widget.urls!.isNotEmpty)
                  // Display images from URLs using ChatBuble
                  ChatBuble(
                    message: "",
                    dateTime: Util.formatData(
                        dateString: widget.message.dateSent ?? 0),
                    // isText: false,
                    isReceiver: widget.message.senderId !=
                        widget.model.currentUser!.id!,
                    color: (widget.message.senderId ==
                            widget.model.currentUser!.id!)
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade200,
                    child: Column(
                      children: widget.urls!.map((url) {
                        if (url.contextType.contains("audio")) {
                          return AppAudioPlayer(
                            audioPath: url.url,
                            onChanged: (val) {
                              // setState(() {
                              //   isPlaying = val;
                              // });
                            },
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              // Display attachment in a dialog with zoom capability
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    elevation: 2.0,
                                    shadowColor: Colors.grey.shade300,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: PhotoView(
                                      imageProvider:
                                          CachedNetworkImageProvider(url.url),
                                    ),
                                  );
                                },
                              );
                            },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: CachedNetworkImage(
                                imageUrl: url.url,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          );
                        }
                      }).toList(),
                    ),
                  )
                else
                  // Display text message using ChatBuble
                  ChatBuble(
                    dateTime: Util.formatData(
                        dateString: widget.message.dateSent ?? 0),
                    message: widget.message.body ?? "N/A",
                    isReceiver: widget.message.senderId !=
                        widget.model.currentUser!.id!,
                    color: (widget.message.senderId ==
                            widget.model.currentUser!.id!)
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade200,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class ChatBubble2 extends StatefulWidget {
//   const ChatBubble2({
//     super.key,
//     required this.message,
//     required this.model,
//     this.urls,
//   });

//   final QBMessage message;
//   final GroupViewModel model;
//   final List<String?>? urls;

//   @override
//   State<ChatBubble2> createState() => _ChatBubble2State();
// }

// class _ChatBubble2State extends State<ChatBubble2> {
//   @override
//   Widget build(BuildContext context) {
//     var alignment = (widget.message.senderId == widget.model.currentUser!.id!)
//         ? Alignment.centerRight
//         : Alignment.centerLeft;

//     return Container(
//       alignment: alignment,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment:
//               (widget.message.senderId == widget.model.currentUser!.id!)
//                   ? CrossAxisAlignment.end
//                   : CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.message.senderId.toString(),
//               style: TextStyle(fontSize: 12, fontFamily: 'Rubik'),
//             ),
//             const SizedBox(height: 5),
//             if (widget.urls != null && widget.urls!.isNotEmpty)
//               Column(
//                 children: widget.urls!.map((url) {
//                   return GestureDetector(
//                     onTap: () {
//                       // Display attachment in a dialog with zoom capability
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return Dialog(
//                             elevation: 2.0,
//                             shadowColor: Colors.grey.shade300,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: PhotoView(
//                               imageProvider: CachedNetworkImageProvider(url!),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.25,
//                       child: CachedNetworkImage(
//                         imageUrl: url ?? '',
//                         placeholder: (context, url) =>
//                             CircularProgressIndicator(),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               )
//             else
//               // Display asset image within the chat bubble
//               Container(
//                 decoration: BoxDecoration(
//                   color:
//                       (widget.message.senderId == widget.model.currentUser!.id!)
//                           ? Theme.of(context).primaryColor
//                           : Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.all(10),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Image.asset(
//                       "assets/images/pngs/abriel.png",
//                       height: 50, // Adjust height as needed
//                       width: 50, // Adjust width as needed
//                       fit: BoxFit.cover,
//                     ),
//                     const SizedBox(width: 10),
//                     Flexible(
//                       child: Text(
//                         widget.message.body ?? "N/A",
//                         style: TextStyle(
//                           color: (widget.message.senderId ==
//                                   widget.model.currentUser!.id!)
//                               ? Colors.white
//                               : Colors.black87,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
