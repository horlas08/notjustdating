import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/presentation/chat/payment_successful.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/home/user/matched_profile.dart';
import 'package:ofwhich_v2/presentation/home/user/plan_date_screen.dart';

class MakePaymentScreen extends StatelessWidget {
  final UserModel profile;
  const MakePaymentScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OfWhichAppBar(titleText: "Make Payment",),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20.w), child: Column(
        children: [
          SizedBox(height: 36.h ,),

          _summaryCard(context,profile.photo ?? ""),
          dividerGap(),
          PaymentMethodSelection(),
               CustomButton(
                    height: 56.h,
                    borderRadius: BorderRadius.circular(15.r),
                   // bgColor: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentSuccessPage(paymentInitiatorType: 'wallet',),
                          ));
                    },
                    child: Text("Pay now",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            //fontFamily: Font.inter,
                            fontWeight: FontWeight.w400)),
                  )

        ],
      ),) ,

    );
  }
}

//PaymentSuccessPage(paymentInitiatorType: 'wallet',)



Widget _paymentMethod(){
  return Container(
    child: Column(
      children: [
        Text("Payment Method", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),)
      ],
    ),
  );
}

Widget _summaryCard(BuildContext context, String image){
  return  Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              //height: 350.h,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    const Color(0xFF4D5BD5),
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 38.h,
                  ),
                  Text(
                    "Pay to schedule your date with Rosie",textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                
                  buildMatchPairWidget(image),
                    SizedBox(
                    height: 31.h,
                  ),
             
                ],
              ),
            );
}

class PaymentMethodSelection extends StatefulWidget {
  @override
  _PaymentMethodSelectionState createState() => _PaymentMethodSelectionState();
}

class _PaymentMethodSelectionState extends State<PaymentMethodSelection> {
  String? selectedMethod;

  final List<String> paymentOptions = [
    "Pay with Card",
    "Pay with Wallet",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 20.h),

        // Generate radio buttons dynamically
        ...paymentOptions.map((method) {
          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.02),
              border: Border.all(color: const Color.fromRGBO(231, 231, 231, 1)),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: RadioListTile<String>(
              value: method,
              groupValue: selectedMethod,
              activeColor: const Color.fromRGBO(236, 88, 115, 1),
              onChanged: (value) {
                setState(() {
                  selectedMethod = value;
                });
              },
              title: Text.rich(
                
                    TextSpan(
                      text: method,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    
                 
                ),
              ),
              controlAffinity: ListTileControlAffinity.trailing,
            ),
          );
        }),
      ],
    );
  }
}
