// // import 'dart:developer';

// import 'package:auto_route/annotations.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ofwhich_v2/application/chat_view_model/chat_view_model.dart';
// // import 'package:ofwhich_v2/domain/user_service/model/firebase_user_model.dart';
// import 'package:ofwhich_v2/presentation/chat/model/message_model.dart';
// // import 'package:ofwhich_v2/presentation/chat/model/recent_matches.dart';
// import 'package:ofwhich_v2/presentation/routes/app_router.dart';
// import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
// import 'package:ofwhich_v2/presentation/utils/util.dart';
// import 'package:provider/provider.dart';
// import 'package:quickblox_sdk/models/qb_dialog.dart';
// import 'package:stacked/stacked.dart';

// import '../../domain/user_service/model/user_object.dart';
// import '../../injectable.dart';
// import '../core/font.dart';
// import '../general_widgets/refresh_widget.dart';

// @RoutePage()
// class ChatHomeScreen extends StatefulWidget {
//   const ChatHomeScreen({super.key});

//   @override
//   State<ChatHomeScreen> createState() => _ChatHomeScreenState();
// }

// class _ChatHomeScreenState extends State<ChatHomeScreen> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await getIt<ChatViewModel>().getMatchedUsers();
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChatViewModel>(
//       builder: (context, model, child) => SafeArea(
//         child: Scaffold(
//             body: RefreshWidget(
//           onRefresh: () async {
//             model.getMatchedUsers();
//             // model.fetchDialogs();
//           },
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // SizedBox(height: 30.h),
//                 Align(
//                     child: Image.asset("assets/images/pngs/logo2.png",
//                         scale: 2.0)),
//                 SizedBox(height: 20.h),
//                 Text("Recent Matches",
//                     style: TextStyle(
//                         fontFamily: Font.inter,
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w700)),
//                 SizedBox(height: 18.h),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.1,
//                     width: MediaQuery.of(context).size.width,
//                     child: model.matchedUsers.isEmpty
//                         ? const Text("No matches yet, get swiping!!!")
//                         : ListView.builder(
//                             itemCount: model.matchedUsers.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               UserModel user = model.matchedUsers[index];
//                               return InkWell(
//                                 onTap: () {
//                                   // getIt<AppRouter>().push(ChatDetails(
//                                   //     matchedUser: user,
//                                   //    ));
//                                 },
//                                 child: CircleAvatar(
//                                   maxRadius: 55.r,
//                                   backgroundColor: Colors.green,
//                                   backgroundImage: CachedNetworkImageProvider(
//                                     model.matchedUsers[index].photo ?? "",
//                                   ),
//                                   // maxRadius: 120.r,
//                                 ),
//                               );
//                             })),
//                 SizedBox(height: 40.h),
//                 Text("Messages",
//                     style: TextStyle(
//                         fontFamily: Font.inter,
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w700)),
//                 SizedBox(height: 18.h),
//                 model.dialogs.isEmpty
//                     ? Text(
//                         "No chats yet...",
//                         style: TextStyle(
//                             fontFamily: Font.inter,
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w700),
//                       )
//                     : SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.53,
//                         child: ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: model.dialogs.length,
//                             scrollDirection: Axis.vertical,
//                             itemBuilder: (context, index) {
//                               QBDialog dialog = model.dialogs[index];

//                               return GestureDetector(
//                                 onTap: () {
//                                   UserModel user = model.getMatchedUser(
//                                       fullName: dialog.name,
//                                       matchedUsers: model.matchedUsers);
//                                   getIt<AppRouter>()
//                                       .push(ChatDetails(matchedUser: user));
//                                 },
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 10.w),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           CircleAvatar(
//                                             maxRadius: 55.r,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceAround,
//                                             children: [
//                                               Text(
//                                                 dialog.name ?? "n/a",
//                                                 style: TextStyle(
//                                                     fontSize: 16.sp,
//                                                     fontWeight: FontWeight.w600,
//                                                     fontFamily: Font.inter),
//                                               ),
//                                               Text(
//                                                 dialog.lastMessage ?? "N/A",
//                                                 style: TextStyle(
//                                                     fontSize: 15.sp,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontFamily: Font.inter),
//                                               )
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           SizedBox(
//                                             height: 10.h,
//                                           ),
//                                           Text(
//                                               Util.formatData(
//                                                   dateString: dialog
//                                                       .lastMessageDateSent!),
//                                               style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   fontWeight: FontWeight.w500,
//                                                   fontFamily: Font.inter,
//                                                   color:
//                                                       const Color(0xFF2B2B2B)))
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }),
//                       )
//               ],
//             ),
//           ),
//         )),
//       ),
//     );
//   }
// }

// // SingleChildScrollView(
// //               child: Padding(
// //             padding: EdgeInsets.symmetric(horizontal: 20.0.w),
// //             child: Column(
// //               children: [
// //                 Text('Likes ${model.matchedUsers.length}',
// //                     style: TextStyle(
// //                         fontFamily: Font.inter,
// //                         fontSize: 16.sp,
// //                         fontWeight: FontWeight.w400)),
// //                 GridView.builder(
// //                     shrinkWrap: true,
// //                     itemCount: model.matchedUsers.length,
// //                     padding: EdgeInsets.all(10.w),
// //                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                         crossAxisCount: 2, // Number of columns
// //                         crossAxisSpacing: 10.0.w,
// //                         mainAxisSpacing: 8.0.w,
// //                         childAspectRatio: 0.75),
// //                     itemBuilder: (context, index) {
// //                       UserModel user = model.matchedUsers[index];
// //                       return InkResponse(
// //                           onTap: () {
// //                             getIt<AppRouter>().push(const SupscriptionHome());
// //                           },
// //                           child: InterestCard(profileLikes: user));
// //                     })
// //               ],
// //             ),
// //           ))
// class InterestCard extends StatelessWidget {
//   const InterestCard({
//     super.key,
//     required this.profileLikes,
//   });

//   final UserModel profileLikes;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//             color: Colors.green, borderRadius: BorderRadius.circular(10.r)),
//         height: MediaQuery.of(context).size.height * 0.1,
//         child: Stack(
//           children: [
//             Positioned(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10.r),
//                 child: CachedNetworkImage(imageUrl: profileLikes.photo ?? ""),
//               ),
//             ),
//             Positioned(
//               bottom: 30.h,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       profileLikes.full_name ?? "",
//                       style: TextStyle(
//                           fontFamily: Font.inter,
//                           fontWeight: FontWeight.w800,
//                           fontSize: 14,
//                           color: Colors.white),
//                     ),
//                     Text(
//                       profileLikes.gender ?? "",
//                       style: TextStyle(
//                         fontFamily: Font.inter,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
// }

// class MessageTile extends StatelessWidget {
//   const MessageTile({
//     super.key,
//     required this.message,
//   });

//   final MessageModel message;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // getIt<AppRouter>().push(ChatDetails(userId: 1.toString(), email: ""));
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 10.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                     maxRadius: 55.r,
//                     backgroundColor:
//                         message.imageUrl == "" ? Colors.white : null,
//                     backgroundImage: message.imageUrl == ""
//                         ? null
//                         : AssetImage(message.imageUrl)),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       message.name,
//                       style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600,
//                           fontFamily: Font.inter),
//                     ),
//                     Text(
//                       message.lastMessage,
//                       style: TextStyle(
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: Font.inter),
//                     )
//                   ],
//                 )
//               ],
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CircleAvatar(
//                   radius: 14.r,
//                   backgroundColor: Colors.black,
//                   child: Text("1",
//                       style: TextStyle(
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w400,
//                           fontFamily: Font.rubik,
//                           color: Colors.white)),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Text(message.date,
//                     style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: Font.inter,
//                         color: const Color(0xFF2B2B2B)))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/chat_view_model/chat_view_model.dart';
// import 'package:ofwhich_v2/domain/user_service/model/firebase_user_model.dart';
import 'package:ofwhich_v2/presentation/chat/model/message_model.dart';
// import 'package:ofwhich_v2/presentation/chat/model/recent_matches.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
// import 'package:ofwhich_v2/presentation/utils/util.dart';
import 'package:provider/provider.dart';
// import 'package:quickblox_sdk/models/qb_dialog.dart';

import '../../domain/user_service/model/user_object.dart';
import '../../injectable.dart';
import '../core/font.dart';
import '../general_widgets/refresh_widget.dart';

@RoutePage()
// class ChatHomeScreen extends StatefulWidget {
//   const ChatHomeScreen({super.key});

//   @override
//   State<ChatHomeScreen> createState() => _ChatHomeScreenState();
// }

// class _ChatHomeScreenState extends State<ChatHomeScreen> {
//   late ChatViewModel _chatViewModel;

//   @override
//   void initState() {
//     super.initState();
//     // Get the ChatViewModel instance
//     _chatViewModel = getIt<ChatViewModel>();

//     // Load data after the widget is built
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await _chatViewModel.getMatchedUsers();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ChatViewModel>.value(
//       value: _chatViewModel,
//       child: Consumer<ChatViewModel>(
//         builder: (context, model, child) => SafeArea(
//           child: Scaffold(
//             body: RefreshWidget(
//               onRefresh: () async {
//                 await model.getMatchedUsers();
//                 // await model.fetchDialogs();
//               },
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.0.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Logo
//                     Align(
//                       child: Image.asset(
//                         "assets/images/pngs/logo2.png",
//                         scale: 2.0,
//                       ),
//                     ),
//                     SizedBox(height: 20.h),

//                     model.isBusy
//                         ? const Center(child: CircularProgressIndicator())
//                         : model.matchedUsers.isEmpty
//                             ? const Center(child: Text('No matches yet'))
//                             : Column(
//                                 children: [
//                                   Text('Matches ${model.matchedUsers.length}',
//                                       style: TextStyle(
//                                           fontFamily: Font.inter,
//                                           fontSize: 16.sp,
//                                           fontWeight: FontWeight.w400)),
//                                   GridView.builder(
//                                       shrinkWrap: true,
//                                       itemCount: model.matchedUsers.length,
//                                       padding: EdgeInsets.all(10.w),
//                                       gridDelegate:
//                                           SliverGridDelegateWithFixedCrossAxisCount(
//                                               crossAxisCount:
//                                                   2, // Number of columns
//                                               crossAxisSpacing: 10.0.w,
//                                               mainAxisSpacing: 8.0.w,
//                                               childAspectRatio: 0.75),
//                                       itemBuilder: (context, index) {
//                                         UserModel profileLikes =
//                                             model.matchedUsers[index];
//                                         return InkResponse(
//                                             onTap: () {
//                                               getIt<AppRouter>().push(
//                                                   PlanADateRoute(
//                                                       type: "requester",
//                                                       dateUserId:
//                                                           profileLikes.id));
//                                             },
//                                             child: Column(
//                                               children: [
//                                                 SizedBox(
//                                                   width:
//                                                       MediaQuery.sizeOf(context)
//                                                               .width *
//                                                           0.4,
//                                                   height:
//                                                       MediaQuery.sizeOf(context)
//                                                               .height *
//                                                           0.2,
//                                                   child: InterestCard(
//                                                       profileLikes:
//                                                           profileLikes),
//                                                 ),
//                                                 Container(
//                                                     height: 50.h,
//                                                     width: 250.w,
//                                                     alignment: Alignment.center,
//                                                     decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(3.r),
//                                                         color: Colors
//                                                             .grey.shade300),
//                                                     child: Text(
//                                                       "Plan a date",
//                                                       style: TextStyle(
//                                                           fontSize: 14.sp,
//                                                           fontWeight:
//                                                               FontWeight.w600),
//                                                     )),
//                                               ],
//                                             ));
//                                       })
//                                 ],
//                               ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen>
    with TickerProviderStateMixin {
  late ChatViewModel _chatViewModel;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _chatViewModel = getIt<ChatViewModel>();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _chatViewModel.getMatchedUsers();
      await _chatViewModel.getDateRequests();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatViewModel>.value(
      value: _chatViewModel,
      child: Consumer<ChatViewModel>(
        builder: (context, model, child) => SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(height: 10.h),
                Align(
                  child: Image.asset(
                    "assets/images/pngs/logo2.png",
                    scale: 2.0,
                  ),
                ),
                SizedBox(height: 20.h),

                // Tab Bar
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black,
                  tabs: const [
                    Tab(text: 'Matches'),
                    Tab(text: 'Requests'),
                  ],
                ),

                // Tab Views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      /// === Matches Tab ===
                      RefreshWidget(
                        onRefresh: () async {
                          await model.getMatchedUsers();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: model.isBusy
                              ? const Center(child: CircularProgressIndicator())
                              : model.matchedUsers.isEmpty
                                  ? const Center(child: Text('No matches yet'))
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Matches ${model.matchedUsers.length}',
                                            style: TextStyle(
                                                fontFamily: Font.inter,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400)),
                                        GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                model.matchedUsers.length,
                                            padding: EdgeInsets.all(10.w),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 10.0.w,
                                                    mainAxisSpacing: 8.0.w,
                                                    childAspectRatio: 0.75),
                                            itemBuilder: (context, index) {
                                              final profileLikes =
                                                  model.matchedUsers[index];
                                              return InkResponse(
                                                onTap: () {
                                                  getIt<AppRouter>().push(
                                                      PlanADateRoute(
                                                          type: "requester",
                                                          dateUserId:
                                                              profileLikes.id));
                                                },
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.4,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.2,
                                                      child: InterestCard(
                                                          profileLikes:
                                                              profileLikes),
                                                    ),
                                                    Container(
                                                      height: 50.h,
                                                      width: 250.w,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      3.r),
                                                          color: Colors
                                                              .grey.shade300),
                                                      child: Text(
                                                        "Plan a date",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                        ),
                      ),

                      /// === Requests Tab ===
                      RefreshWidget(
                        onRefresh: () async {
                          // await model.getRequests();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: model.isBusy
                              ? const Center(child: CircularProgressIndicator())
                              : model.dateFetch.isEmpty
                                  ? const Center(
                                      child: Text('No date requests yet'))
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Date Requests ${model.dateFetch.length}',
                                            style: TextStyle(
                                                fontFamily: Font.inter,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400)),
                                        GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: model.dateFetch.length,
                                            padding: EdgeInsets.all(10.w),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 10.0.w,
                                                    mainAxisSpacing: 8.0.w,
                                                    childAspectRatio: 0.75),
                                            itemBuilder: (context, index) {
                                              final dateFetched =
                                                  model.dateFetch[index];
                                              return Column(
                                                children: [
                                                  SizedBox(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.4,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.2,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.r),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10.r)),
                                                        ),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                        child: Stack(
                                                          children: [
                                                            Positioned.fill(
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: dateFetched
                                                                          .requester
                                                                          ?.photo ??
                                                                      "",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Container(
                                                                    color: Colors
                                                                            .grey[
                                                                        300],
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Container(
                                                                    color: Colors
                                                                            .grey[
                                                                        300],
                                                                    child: const Icon(
                                                                        Icons
                                                                            .error),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 10.h,
                                                              left: 10.w,
                                                              right: 10.w,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    dateFetched
                                                                            .requester
                                                                            ?.fullName ??
                                                                        "Unknown",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          Font.inter,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    dateFetched
                                                                            .requester
                                                                            ?.gender ??
                                                                        "",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          Font.inter,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Colors
                                                                              .grey[
                                                                          300],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Container(
                                                    height: 50.h,
                                                    width: 250.w,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.r),
                                                        color: Colors
                                                            .grey.shade300),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: InkWell(
                                                          onTap: () {
                                                            getIt<AppRouter>().push(
                                                                PlanADateRoute(
                                                                    type:
                                                                        "requested",
                                                                    dateId:
                                                                        dateFetched
                                                                            .id));
                                                          },
                                                          child: const Icon(
                                                            Icons.thumb_up,
                                                            color: Colors.green,
                                                          ),
                                                        )),
                                                        Expanded(
                                                            child: InkWell(
                                                          onTap: () {
                                                            model.rejectDateRequest(
                                                                dateId:
                                                                    dateFetched
                                                                        .id);
                                                          },
                                                          child: const Icon(
                                                              Icons.thumb_down,
                                                              color:
                                                                  Colors.red),
                                                        ))
                                                        // Text(
                                                        //   "Accept Invite",
                                                        //   style: TextStyle(
                                                        //       fontSize: 14.sp,
                                                        //       fontWeight:
                                                        //           FontWeight
                                                        //               .w600),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InterestCard extends StatelessWidget {
  const InterestCard({
    super.key,
    required this.profileLikes,
  });

  final UserModel profileLikes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
      ),
      height: MediaQuery.of(context).size.height * 0.1,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: profileLikes.photo ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.h,
            left: 10.w,
            right: 10.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileLikes.full_name ?? "Unknown",
                  style: TextStyle(
                    fontFamily: Font.inter,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
                Text(
                  profileLikes.gender ?? "",
                  style: TextStyle(
                    fontFamily: Font.inter,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // getIt<AppRouter>().push(ChatDetails(userId: 1.toString(), email: ""));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  maxRadius: 55.r,
                  backgroundColor: message.imageUrl == "" ? Colors.white : null,
                  backgroundImage: message.imageUrl == ""
                      ? null
                      : AssetImage(message.imageUrl),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      message.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: Font.inter,
                      ),
                    ),
                    Text(
                      message.lastMessage,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: Font.inter,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 14.r,
                  backgroundColor: Colors.black,
                  child: Text(
                    "1",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: Font.rubik,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  message.date,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: Font.inter,
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
