// import 'package:flutter/foundation.dart';
// ignore_for_file: must_be_immutable

// import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ofwhich_v2/application/profile/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import '../../injectable.dart';
// import 'model/payment_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pay/pay.dart';

import '../core/font.dart';
import '../general_widgets/custom_appbar.dart';
import '../general_widgets/custom_button.dart';
import 'model/subscription_model.dart';

@RoutePage()
class SupscriptionHome extends StatefulWidget {
  const SupscriptionHome({super.key});

  @override
  State<SupscriptionHome> createState() => _SupscriptionHomeState();
}

class _SupscriptionHomeState extends State<SupscriptionHome> {
  // late final Future<PaymentConfiguration> _googlePayConfigFuture;
  int currentIndex = -1;
  late SubscriptionModel subb;
  @override
  void initState() {
    super.initState();
    // _googlePayConfigFuture =
    //     PaymentConfiguration.fromAsset('default_google_pay_config.json');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      // viewModelBuilder: () => getIt<ProfileViewModel>(),
      builder: (context, model, child) => Scaffold(
        appBar: const OfWhichAppBar(
          titleText: "Subscription",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text("Upgrade to a premium user",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: Font.inter,
                    )),
                SizedBox(height: 10.h),
                Text("Get access to all Not just dating features",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF454545),
                        fontFamily: Font.inter)),
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        subb = subcriptionList[index];
                        return InkResponse(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: SubscriptionCard(
                              sub: subb, isSelected: currentIndex == index),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 10.w,
                        );
                      },
                      itemCount: subcriptionList.length),
                ),
                SizedBox(
                  height: 60.h,
                ),
                const Column(children: [
                  TitleWidget(title: "See who visited you"),
                  TitleWidget(title: "Gain access to a Not just dating rooms"),
                  TitleWidget(title: "Remove every advertisement"),
                  TitleWidget(title: "Hide your distance and your age"),
                  TitleWidget(title: "Send flower to your matches"),
                ]),
                // Platform.isAndroid
                //     ? GooglePayButton(
                //         paymentConfiguration:
                //             PaymentConfiguration.fromJsonString(defaultGooglePay),
                //         paymentItems: _paymentItems,
                //         type: GooglePayButtonType.buy,
                //         margin: const EdgeInsets.only(top: 15.0),
                //         onPaymentResult: onGooglePayResult,
                //         loadingIndicator: const Center(
                //           child: CircularProgressIndicator(),
                //         ),
                //       )
                //     :
                //     // Example pay button configured using a string
                //     ApplePayButton(
                //         paymentConfiguration:
                //             PaymentConfiguration.fromJsonString(defaultApplePay),
                //         paymentItems: _paymentItems,
                //         style: ApplePayButtonStyle.black,
                //         type: ApplePayButtonType.buy,
                //         margin: const EdgeInsets.only(top: 15.0),
                //         onPaymentResult: onApplePayResult,
                //         loadingIndicator: const Center(
                //           child: CircularProgressIndicator(),
                //         ),
                //       ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.w),
          child: CustomButton(
            height: 70.h,
            borderRadius: BorderRadius.circular(15.r),
            onPressed: () async {
              model.subscribe(paymentType: "CARD", plan: subb.value);
            },
            child: model.isBusy
                ? const CircularProgressIndicator()
                : Text("Continue",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: Font.inter,
                        color: Colors.white)),
          ),
        ),
      ),
    );
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.w),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("assets/images/pngs/check_pentagon.png", scale: 1.2),
              SizedBox(width: 10.w),
              Text(title,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: Font.inter,
                      color: Colors.black))
            ],
          ),
          Divider(color: Colors.grey.shade400)
        ],
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  SubscriptionCard({super.key, required this.sub, this.isSelected = false});

  final SubscriptionModel sub;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: isSelected ? Theme.of(context).primaryColor : null,
      elevation: isSelected ? 4.0 : 0.0,
      color: Colors.white,
      // shape: RoundedRectangleBorder(),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.35,
          decoration: BoxDecoration(
              color: Colors.white,
              // color: Colors.blueAccent,
              border: isSelected
                  ? Border.all(color: Theme.of(context).primaryColor)
                  : Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: isSelected
                          ? Image.asset(
                              "assets/images/pngs/selection_circle.png",
                              scale: 1.6)
                          : Container(
                              height: 20.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFE3E3E3)),
                                  shape: BoxShape.circle),
                            ),
                    ),
                    Text(sub.title,
                        style: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.black,
                            fontFamily: Font.inter,
                            fontWeight: FontWeight.w600)),
                    Text(sub.duration,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF646464),
                            fontWeight: FontWeight.w400,
                            fontFamily: Font.rubik)),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(maxHeight: 60.h, minHeight: 30.h),
                  height: 50.h,
                  child: Text(sub.oldAmount ?? "",
                      style: TextStyle(
                        color: const Color(0xFF838383),
                        fontFamily: Font.inter,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration
                            .lineThrough, // This adds the strikethrough
                        decorationColor: const Color(
                            0xFF838383), // Optional: Sets the color of the line
                        decorationThickness:
                            2, // Optional: Sets the thickness of the line
                        decorationStyle: TextDecorationStyle.solid,
                      )),
                ),
                Column(
                  children: [
                    Text(sub.amount,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color(0xFF646464),
                          fontWeight: FontWeight.w400,
                        )),
                    Text(sub.amountPerDuration,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF646464),
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
