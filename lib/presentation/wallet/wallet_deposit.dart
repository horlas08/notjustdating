// import 'package:flutter/foundation.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/transaction/transaction_view_model.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../core/font.dart';
import '../general_widgets/custom_appbar.dart';
import 'model/wallet_deposit_model.dart';

@RoutePage()
class WalletDeposit extends StatefulWidget {
  const WalletDeposit({super.key});

  @override
  State<WalletDeposit> createState() => _WalletDepositState();
}

class _WalletDepositState extends State<WalletDeposit> {
  int currentIndex = -1;
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: const OfWhichAppBar(
            titleText: "Deposit", backgroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text("Deposit in your wallet",
                    style: TextStyle(
                        fontFamily: Font.inter,
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                    "Choose your preferred amount of credit you’ll love \nto deposited into your wallet",
                    style: TextStyle(
                        fontFamily: Font.inter,
                        fontSize: 14.sp,
                        color: const Color(0xFF454545),
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: depostTypes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.w,
                            // mainAxisExtent: 0.65,
                            childAspectRatio: 0.75,
                            mainAxisSpacing: 10.w),
                        itemBuilder: (context, index) {
                          WalletDepositModel walletDepositModel =
                              depostTypes[index];
                          return InkResponse(
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                                amountController.text =
                                    walletDepositModel.credit;
                              });
                            },
                            child: Card(
                              shadowColor: currentIndex == index
                                  ? Theme.of(context).primaryColor
                                  : null,
                              elevation: currentIndex == index ? 4.0 : 0.0,
                              color: Colors.white,
                              child: Container(
                                  decoration: BoxDecoration(
                                      // color: Colors.pink,
                                      border: currentIndex == index
                                          ? Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor)
                                          : Border.all(
                                              color: Colors.grey.shade300),
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.w),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: currentIndex == index
                                              ? Image.asset(
                                                  "assets/images/pngs/selection_circle.png",
                                                  scale: 1.8)
                                              : Container(
                                                  height: 15.h,
                                                  width: 15.w,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xFFE3E3E3)),
                                                      shape: BoxShape.circle),
                                                ),
                                        ),
                                        Text(walletDepositModel.credit,
                                            style: TextStyle(
                                                fontSize: 28.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: Font.inter)),
                                        Text("Credits",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: const Color(0xFF646464),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: Font.inter)),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        Text(walletDepositModel.amount,
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                color: const Color(0xFF646464),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: Font.inter))
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        })),
                CustomTextFieldWidget(
                  controller: amountController,
                  textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: Font.inter,
                      color: const Color(0xFF434343)),
                  prefix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "₦",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: Font.inter,
                            color: Theme.of(context).primaryColor),
                      ),
                      VerticalDivider(
                        color: Colors.grey[400],
                      )
                    ],
                  ),
                ),
                CustomButton(
                  height: 65.h,
                  onPressed: () {
                    model.updateUserWallet(
                        amount: num.parse(amountController.text));
                  },
                  borderRadius: BorderRadius.circular(10.r),
                  child: model.isBusy
                      ? const CircularProgressIndicator()
                      : Text(
                          "Deposit",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: Font.inter,
                              color: Colors.white),
                        ),
                ),
                SizedBox(
                  height: 100.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
