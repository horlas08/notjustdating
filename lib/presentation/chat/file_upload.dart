// import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ofwhich_v2/application/chat_view_model/chat_view_model.dart';
import 'package:stacked/stacked.dart';

// import '../core/font.dart';
import '../../injectable.dart';
import '../general_widgets/custom_appbar.dart';
import '../general_widgets/custom_textfield.dart';

@RoutePage()
class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key, required this.selectedPhoto, this.userId});
  final File selectedPhoto;
  final String? userId;

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => getIt<ChatViewModel>(),
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
            titleText: "File Upload",
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              children: [
                // FileImage(file)
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Image.file(widget.selectedPhoto)),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomTextFieldWidget(
                        controller: controller,
                        filled: true,
                        fillColor: const Color(0XFFF5F6FC),
                        hintText: "Type a message",
                        hintStyle: TextStyle(
                            fontSize: 16.sp, color: const Color(0xFF888888)),

                        // border: OutlineInputBorder(
                        // borderSide:
                        //     const BorderSide(color: Colors.transparent),
                        // borderRadius: BorderRadius.circular(15.r),
                      ),

                      // ),
                    ),
                    model.isBusy
                        ? const Expanded(
                            child: Center(child: CircularProgressIndicator()))
                        : Expanded(
                            child: Row(
                              children: [
                                Transform.scale(
                                    scale: 0.5,
                                    child: Image.asset(
                                        "assets/images/pngs/emojies_large.png")),
                                GestureDetector(
                                  onTap: () async {
                                    // if (controller.text.isNotEmpty) {
                                    //   await model.sendMessage(
                                    //       receiverId: widget.userId ?? "",
                                    //       message: controller.text);
                                    // }
                                    model.uploadImage(
                                        file: widget.selectedPhoto,
                                        receiverId: widget.userId ?? "",
                                        message: controller.text);
                                    controller.clear();
                                    context.router.pop();
                                    // getIt<AppRouter>().pop();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/images/svgs/send_icon.svg"),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
