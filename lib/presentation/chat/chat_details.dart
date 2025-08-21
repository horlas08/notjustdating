// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_emoji_picker/keyboard_emoji_picker.dart';
import 'package:ofwhich_v2/application/chat_view_model/qb_attachment_model.dart';
import 'package:ofwhich_v2/presentation/chat/widgets/chat_bubble.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';
// import 'package:ofwhich_v2/presentation/group_chat/group_chat_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
// import 'package:record/src/record.dart';
import 'package:stacked/stacked.dart';

// import 'package:record_example/audio_player.dart';
// import 'package:record_example/audio_recorder.dart';
import '../../application/chat_view_model/chat_view_model.dart';
import '../../application/profile/profile_view_model.dart';
import '../../domain/user_service/model/user_object.dart';
import '../../injectable.dart';
import '../core/font.dart';
// import '../general_widgets/custom_appbar.dart';
// import '../routes/app_router.dart';
// import '../routes/app_router.gr.dart';
import '../general_widgets/app_audio_player.dart';
import '../utils/util.dart';
import 'widgets/chat_app_bar.dart';

@RoutePage()
class ChatDetails extends StatefulWidget {
  const ChatDetails(
      {super.key,
      // required this.userId,
      // required this.email,
      required this.matchedUser});
  // final String userId;
  // final String email;
  final UserModel matchedUser;
  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  TextEditingController controller = TextEditingController();
  RecorderController recordController = RecorderController();
  String path = "";
  String dialogId = "";
  QBUser? matchedQBUser;
  bool isUserOnline = false;
  bool isPlaying = false;
  bool _isSending = false;

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _audioPath;

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
    print("Recording saved at: $_audioPath");
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

  final ScrollController _scrollController = ScrollController();
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
    return ViewModelBuilder<ChatViewModel>.reactive(
      onViewModelReady: (h) async {
        await h.getSavedUaser();
        await h.getCurrentUser();
        await h.getUserSavedLocally();

        // await h.connectToChat(login: login, password: password)
        // await h.createPersonalChat(dialogName: "test dialog");
        // await h.updateDilaog();
        // h.audioPlayer = AudioPlayer();
        // h.audioRecord = AudioRecorder();

        await h.manageChat(
            matchedUserId: widget.matchedUser,
            done: (val) {
              log("value from manage chat $val");
              setState(() {
                dialogId = val;
              });
            });
        matchedQBUser = await h.getMatchedUserId(
            dialogId: dialogId, matchedUser: widget.matchedUser);
        isUserOnline =
            await h.checkUserPresence(userId: matchedQBUser?.id ?? 0);
        await h.loadMessages(dialogId: dialogId).then((_) {
          h.subscribeNewMessage();
          _scrollToBottom();
        });
        h.subscribeToTypingEvents(h.dialogId);
        h.messageStream.listen((event) {
          _scrollToBottom();
        });
        h.typingStream.listen((event) {
          log("evennttttt:::::: $event");
          log("user is typinggggggg");
        });
      },
      viewModelBuilder: () => getIt<ChatViewModel>(),
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
                  Text(widget.matchedUser.full_name ?? "N/A",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: Font.inter)),
                  isUserOnline
                      ? Text("Online",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.green,
                              fontWeight: FontWeight.w400,
                              fontFamily: Font.inter))
                      : Text("Offline",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFFA4A4A4),
                              fontWeight: FontWeight.w400,
                              fontFamily: Font.inter))
                ],
              )
            ]),
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: Image.asset("assets/images/pngs/video_call_icon.png"),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: Image.asset("assets/images/pngs/audio_call_icon.png"),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 5.0.w, bottom: 10.w),
                  child: const Icon(Icons.menu))
            ],
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
                          log("attchmetnntssss:::::::::" +
                              attachmentModels.toList().toString());
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
                                  return ChatBubble(
                                    fetchUserById: model.getMatchedUserId,
                                    model: model,
                                    message: message,
                                    matchedUser: widget
                                        .matchedUser, // Ensure matchedUser is passed
                                    dialogId: dialogId,
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
                                    fetchUserById: model.getMatchedUserId,
                                    model: model,
                                    message: message,
                                    urls: attachmentUrls,
                                    matchedUser: widget
                                        .matchedUser, // Ensure matchedUser is passed
                                    dialogId: dialogId);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
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
                              // model.isRecording
                              //     ? GestureDetector(
                              //         onTap: () async {
                              //           // await recordController.stop();
                              //           // setState(() {
                              //           //   model.isRecordingDone = true;
                              //           // });
                              //         },
                              //         child: AudioWaveforms(
                              //             size: Size(
                              //                 MediaQuery.of(context).size.width, 200.0),
                              //             recorderController: recordController,
                              //             enableGesture: true,
                              //             waveStyle: const WaveStyle(
                              //               //  color: Colors.white,
                              //               showDurationLabel: true,
                              //               spacing: 8.0,
                              //               showBottom: false,
                              //               extendWaveform: true,
                              //               showMiddleLine: false,
                              //               // gradient:ui.Gradient.linear(
                              //               //   const Offset(70, 50),
                              //               //   Offset(
                              //               //       MediaQuery.of(context).size.width / 2,
                              //               //       0),
                              //               //   [Colors.red, Colors.green],
                              //               // ),
                              //             ),
                              //             decoration: BoxDecoration(
                              //               borderRadius: BorderRadius.circular(12.0),
                              //               color: const Color(0xFF1E1B26),
                              //             ),
                              //             padding: const EdgeInsets.only(left: 18),
                              //             margin: const EdgeInsets.symmetric(
                              //                 horizontal: 15)),
                              //       )
                              //     :
                              // model.isRecordingDone
                              //     ? Row(
                              //         children: [
                              //           const Icon(Icons.play_arrow),
                              //           SizedBox(
                              //               width:
                              //                   MediaQuery.of(context).size.width *
                              //                       0.5,
                              //               child: const LinearProgressIndicator(
                              //                   value: 0.6))
                              //         ],
                              //       )
                              : CustomTextFieldWidget(
                                  controller: controller,
                                  onChanged: (val) {
                                    if (val.isNotEmpty) {
                                      model.sendIsTyping(dialogId: dialogId);
                                    } else {
                                      model.sendTypingStopped(
                                          dialogId: dialogId);
                                    }
                                  },
                                  onTap: () {},
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
                                  }
                                  // border: OutlineInputBorder(
                                  // borderSide:
                                  //     const BorderSide(color: Colors.transparent),
                                  // borderRadius: BorderRadius.circular(15.r),
                                  ),

                          // ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                        dialogId:
                                                            model.dialogId);
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
                                                        dialogId: model
                                                                .dialogId ??
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
                                          dialogId: dialogId)

                                      // _scrollToBottom();

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
                                        print(
                                            "Attachment sent successfully, audio player removed.");
                                      });
                                    },
                                    fileType: "audio",
                                    file: File(_audioPath!),
                                    dialogId: dialogId,
                                  );
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

  // Widget buildMessageList(ChatViewModel model) {
  //   return StreamBuilder(
  //     stream: model.getMessages(
  //         userId: widget.userId, otherUserId: model.user!.id.toString()),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return Text("Error ${snapshot.error}");
  //       }
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Text("Loading......");
  //       }
  //       return ListView(
  //           children: snapshot.data!.docs
  //               .map((document) => _buildMessageItem(document, model))
  //               .toList());
  //     },
  //   );
  // }

//   Widget _buildMessageItem(DocumentSnapshot document, ChatViewModel model) {
//     Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//     var alignment = (data['senderId'] == model.user?.id.toString())
//         ? Alignment.centerRight
//         : Alignment.centerLeft;
//     return Container(
//       alignment: alignment,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: (data['senderId'] == model.user?.id.toString())
//               ? CrossAxisAlignment.end
//               : CrossAxisAlignment.start,
//           children: [
//             Text(data["senderEmail"],
//                 style: TextStyle(fontSize: 12.sp, fontFamily: Font.rubik)),
//             SizedBox(
//               height: 5.h,
//             ),
//             data["message"].contains("https://firebasestorage")
//                 ? ChatBuble(
//                     color: (data['senderId'] == model.user?.id.toString())
//                         ? Theme.of(context).primaryColor
//                         : Colors.grey.shade200,
//                     onTap: () {
//                       showDialog(
//                           context: context,
//                           builder: (context) {
//                             return Dialog(
//                                 elevation: 2.0,
//                                 shadowColor: Colors.grey.shade300,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.r)),
//                                 child: PhotoView(
//                                   imageProvider: CachedNetworkImageProvider(
//                                       data["message"]),
//                                 ));
//                           });
//                     },
//                     message: "",
//                     isText: false,
//                     child: SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.25,
//                         child: CachedNetworkImage(imageUrl: data["message"])),
//                   )
//                 : ChatBuble(
//                     color: (data['senderId'] == model.user?.id.toString())
//                         ? Theme.of(context).primaryColor
//                         : Colors.grey.shade200,
//                     isReceiver: (data['senderId'] != model.user?.id.toString()),
//                     message: data["message"])
//           ],
//         ),
//       ),
//     );
//   }
}

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.model,
    required this.fetchUserById,
    this.matchedUser,
    this.dialogId,
    this.urls,
  });

  final QBMessage message;
  final ChatViewModel model;
  final List<QBAttachmentModel>? urls;
  final UserModel? matchedUser;
  final String? dialogId;
  final Future<QBUser?> Function(
      {required UserModel matchedUser, required String dialogId}) fetchUserById;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  String userEmail = '';
  @override
  void initState() {
    // sender = widget.getQBUser.call(widget.message.senderId ?? 0);
    // receiver = widget.getQBUser.call(widget.model.currentUser?.id ?? 0);

    super.initState();
    _getUserEmail();
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
      final user = await widget.fetchUserById(
          matchedUser: widget.matchedUser!, dialogId: widget.dialogId!);

      return user?.fullName ?? 'Unknown User';
    } catch (e) {
      log('Error fetching username: $e');
      return 'Unknown User';
    }
  }

  Future<void> _getUserEmail() async {
    final int senderId = widget.message.senderId ?? 0;
    final int currentUserId = widget.model.currentUser?.id ?? 0;

    // Check if the message is from the current user
    if (senderId == currentUserId) {
      // Show current user's email

      userEmail = widget.model.currentUser?.fullName ?? 'Unknown';
    } else if (senderId != 0) {
      // Fetch the sender's email if it is not the current user
      final user = await widget.fetchUserById(
          matchedUser: widget.matchedUser!, dialogId: widget.dialogId!);

      userEmail = user?.fullName ?? 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    var alignment = (widget.message.senderId == widget.model.currentUser!.id!)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
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
            // Text(
            //   userEmail,
            //   // widget.message.senderId.toString(),
            //   style: TextStyle(fontSize: 12.sp, fontFamily: Font.inter),
            // ),
            const SizedBox(height: 5),
            if (widget.urls != null && widget.urls!.isNotEmpty)
              // Display images from URLs using ChatBuble
              ChatBuble(
                message: "",
                dateTime:
                    Util.formatData(dateString: widget.message.dateSent ?? 0),
                // isText: false,
                isReceiver:
                    widget.message.senderId != widget.model.currentUser!.id!,
                color:
                    (widget.message.senderId == widget.model.currentUser!.id!)
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
                dateTime:
                    Util.formatData(dateString: widget.message.dateSent ?? 0),
                message: widget.message.body ?? "N/A",
                isReceiver:
                    widget.message.senderId != widget.model.currentUser!.id!,
                color:
                    (widget.message.senderId == widget.model.currentUser!.id!)
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade200,
              ),
          ],
        ),
      ),
    );
  }
}
