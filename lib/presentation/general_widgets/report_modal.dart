import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:ofwhich_v2/application/chat_view_model/chat_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';

// import '../../domain/user_service/model/user_object.dart';
import '../core/font.dart';
import 'custom_button.dart';

class ReportModal extends StatefulWidget {
  const ReportModal(
      {super.key, required this.userId, this.showBlockButton = true});
  final String userId;
  final bool showBlockButton;
  @override
  State<ReportModal> createState() => _ReportModalState();
}

class _ReportModalState extends State<ReportModal> {
  TextEditingController conplaint = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.58,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text("Make Report",
                  style: TextStyle(
                      fontFamily: Font.inter,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 10.h),
              Text(
                  "Feel any threat or user post any form of offensive post, send your report below",
                  style: TextStyle(
                      fontFamily: Font.inter,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400)),
              SizedBox(height: 40.h),
              CustomTextFieldWidget(
                controller: conplaint,
                label: "Your complaint*",
                labelTextStyle: TextStyle(
                    color: const Color(0xFF535353),
                    fontSize: 16.sp,
                    fontFamily: Font.rubik),
                macLines: 5,
                // contentPadding: EdgeInsets.all(100.w),
              ),
              CustomButton(
                height: 65.h,
                borderRadius: BorderRadius.circular(10.r),
                onPressed: () {
                  if (conplaint.text.isNotEmpty) {
                    getIt<ChatViewModel>().reportMessage(
                        reportedUserId: int.parse(widget.userId),
                        reportedContent: conplaint.text.trim());
                    conplaint.text = "";
                    Navigator.pop(context);
                  } else {
                    getIt<ChatViewModel>()
                        .snackbarHandlerImpl
                        .showErrorSnackbar("Enter a complaint to proceed");
                  }
                },
                child: getIt<ChatViewModel>().isBusy
                    ? const CircularProgressIndicator()
                    : Text(
                        "Send Report",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontFamily: Font.inter),
                      ),
              ),
              SizedBox(height: 10.h),
              widget.showBlockButton
                  ? Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.white,
                              builder: (context) {
                                return const BlocModal();
                              });
                        },
                        style: const ButtonStyle(),
                        child: Text(
                          "Block User",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontFamily: Font.inter),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class BlocModal extends StatefulWidget {
  const BlocModal({
    super.key,
  });

  @override
  State<BlocModal> createState() => _BlocModalState();
}

class _BlocModalState extends State<BlocModal> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.w),
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Image.asset("assets/images/pngs/block_image.png"),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("Block Account",
                          style: TextStyle(
                              fontFamily: Font.inter,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                              color: Colors.black)),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              text:
                                  "They wont be able to find your profile, \npost or story;",
                              style: TextStyle(
                                  fontFamily: Font.inter,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                    text: " Not just Dating",
                                    style: TextStyle(
                                        fontFamily: Font.inter,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        " won’t let \nthem know you blocked them.",
                                    style: TextStyle(
                                        fontFamily: Font.inter,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400))
                              ])),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const Divider(),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text("Block",
                          style: TextStyle(
                              fontFamily: Font.inter,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFD50100)))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
