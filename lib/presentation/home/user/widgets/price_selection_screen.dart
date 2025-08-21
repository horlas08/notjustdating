import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/home/user/choose_date_screen.dart';

class PriceSelectionScreen extends StatefulWidget {

  final UserModel profile;

  const PriceSelectionScreen({super.key, required this.profile});
  @override
  _PriceSelectionScreenState createState() => _PriceSelectionScreenState();
}

class _PriceSelectionScreenState extends State<PriceSelectionScreen> {
  String? selectedPrice; // Holds the selected price value

  final List<Map<String, String>> priceOptions = [
    {"price": "100", "details": "Budget Friendly"},
    {"price": "200", "details": "Moderate pricing"},
    {"price": "500", "details": "Expensive"},
    {"price": "1000", "details": "Luxury"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Generate radio buttons dynamically
          ...priceOptions.map((option) {
            return Container(
              margin: EdgeInsets.only(bottom: 19.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.02),
                border: Border.all(color: Color.fromRGBO(231, 231, 231, 1)),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: RadioListTile<String>(
                value: option["price"]!,
                groupValue: selectedPrice,
                activeColor: const Color.fromRGBO(236, 88, 115, 1),
                onChanged: (value) {
                  setState(() {
                    selectedPrice = value;
                  });
                },
                title: Text.rich(
                  TextSpan(
                    text: "\$${option["price"]} - ",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: option["details"],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400, 
                        ),
                      ),
                    ],
                  ),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            );
          }),
      
         // SizedBox(height: 19.h,),
      
          CustomButton(
            height: 56.h,
            borderRadius: BorderRadius.circular(15.r),
            width: MediaQuery.of(context).size.width,
            onPressed: selectedPrice == null
                ? null // Disable button if nothing selected
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseDateScreen(profile: widget.profile,),
                      ),
                    );
                  },
            child: Text(
              "Next",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                //  fontFamily: Font.inter,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
