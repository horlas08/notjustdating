import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';
import 'package:stacked/stacked.dart';

import '../../../../application/post_view_model/content_creator/post_view_model.dart';
import '../../../../injectable.dart';
import '../../../core/font.dart';

@RoutePage()
class TagUsers extends StatefulWidget {
  const TagUsers({super.key});

  @override
  State<TagUsers> createState() => _TagUsersState();
}

class _TagUsersState extends State<TagUsers> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.reactive(
      onViewModelReady: (s) {
        s.getUsers();
      },
      viewModelBuilder: () => getIt<PostViewModel>(),
      builder: (context, model, child) => Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.72,
                      child: CustomTextFieldWidget(
                        controller: controller,
                        prefix: const Icon(Icons.search),
                        hintText: "Search users ...",
                        onTap: () {
                          model.setIsSearching(true);
                        },
                        onChanged: (h) {
                          model.searchUsers(val: h);
                        },
                      )),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // getIt<AppRouter>().pop();
                    },
                    child: Text("Cancel",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: Font.rubik,
                            fontWeight: FontWeight.w500)),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              if (model.isSearching) ...[
                if (model.filteredUsers.isEmpty)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment.center,
                    child: Text("No results found",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontFamily: Font.rubik,
                            fontWeight: FontWeight.w500)),
                  )
                else
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.78,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 20.h,
                          );
                        },
                        itemCount: model.filteredUsers.length,
                        shrinkWrap: false,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              // getIt<AppRouter>()
                              //     .pop(model.filteredUsers[index]);
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  minRadius: 30.r,
                                  backgroundImage: CachedNetworkImageProvider(
                                      model.filteredUsers[index].photo ??
                                          "N/A"),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                    model.filteredUsers[index].full_name ??
                                        "N/A",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontFamily: Font.rubik,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          );
                        },
                      )),
              ] else if (model.isBusy) ...[
                Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator())
              ] else ...[
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.78,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20.h,
                        );
                      },
                      itemCount: model.users.length,
                      shrinkWrap: false,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // log("callellllleddddd");
                            Navigator.pop(context);
                            // getIt<AppRouter>()
                            //     .pop<UserModel>(model.users[index]);
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                minRadius: 30.r,
                                backgroundImage: CachedNetworkImageProvider(
                                    model.users[index].photo ?? "N/A"),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(model.users[index].full_name ?? "N/A",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontFamily: Font.rubik,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        );
                      },
                    ))
              ]
            ],
          ),
        ),
      )),
    );
  }
}
