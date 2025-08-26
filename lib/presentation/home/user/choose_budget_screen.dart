import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/domain/user_service/model/user_object.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/home/user/widgets/price_selection_screen.dart';

class ChooseBudgetScreen extends StatelessWidget {
  final UserModel profile;
  const ChooseBudgetScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OfWhichAppBar(
        titleText: "Plan a Date",
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 26.h,
            ),
            Text(
              "Choose budget",
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "How much will you like to spend on your date?",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 35.h,
            ),
            Expanded(
              child: PriceSelectionScreen(
                profile: profile,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _priceTile(String price, String priceDetails) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    height: 63.h,
    decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.02),
        border: Border.all(color: Color.fromRGBO(231, 231, 231, 1)),
        borderRadius: BorderRadius.circular(15.r)),
    child: Row(
      children: [
        Text.rich(
          TextSpan(
              text: "\$$price - ",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: "$priceDetails",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                )
              ]),
        ),
      ],
    ),
  );
}

class RadioButtonSelectio extends StatefulWidget {
  final Function(String) onChanged;

  const RadioButtonSelectio({Key? key, required this.onChanged})
      : super(key: key);

  @override
  _RadioButtonSelectioState createState() => _RadioButtonSelectioState();
}

class _RadioButtonSelectioState extends State<RadioButtonSelectio> {
  String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text("Select Gender"),
          RadioListTile<String>(
            title: Text.rich(
              TextSpan(
                  text: "\$ - ",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(
                      text: "Budget friendly",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    )
                  ]),
            ),
            value: 'male',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() => _selectedGender = value!);
              widget.onChanged(value!);
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          RadioListTile<String>(
            title: const Text("Female"),
            value: 'female',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() => _selectedGender = value!);
              widget.onChanged(value!);
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          RadioListTile<String>(
            title: const Text("Gender nonconformaring folks"),
            value: 'Gender nonconformaring folks',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() => _selectedGender = value!);
              widget.onChanged(value!);
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
        ],
      ),
    );
  }
}
