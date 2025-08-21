// import 'package:flutter/foundation.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/transaction/transaction_view_model.dart';
// import 'package:flutter/widgets.dart';
import 'package:ofwhich_v2/presentation/general_widgets/app_back_button.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
// import 'package:ofwhich_v2/presentation/wallet/model/wallet_transaction_model.dart' as walletTrn;
import 'package:provider/provider.dart';

import '../../injectable.dart';
import '../core/font.dart';
import 'widgets/transaction_bottom_sheet.dart';

@RoutePage()
class WalletHomePage extends StatefulWidget {
  const WalletHomePage({super.key, this.walletBalance = 0});
  final num walletBalance;

  @override
  State<WalletHomePage> createState() => _WalletHomePageState();
}

class _WalletHomePageState extends State<WalletHomePage>
    with SingleTickerProviderStateMixin {
  // late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this); // 3 tabs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<TransactionViewModel>().getWalletTransactions(pageNumber: 1);
    });

    // getIt<TransactionViewModel>().getCreditTransaction();
    // getIt<TransactionViewModel>().getDebitTransaction();
  }

  @override
  void dispose() {
    // _tabController.dispose(); // Dispose of the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionViewModel>(builder: (context, model, child) {
      return Scaffold(
          bottomSheet: const TransactionBottomSheet(),
          backgroundColor: const Color(0xFFEC5873),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 35.h,
                  ),
                  Row(
                    children: [
                      const AppBackButton(
                        arrowColor: Colors.white,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "My Wallet",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: Font.inter,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 48
                              .h), // Reserve space to match AppBackButton's width
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "${widget.walletBalance} Credits",
                    style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: Font.inter,
                        color: Colors.white),
                  ),
                  Text("Total Balance",
                      style: TextStyle(
                          color: const Color(0xFFFFC4CE),
                          fontSize: 14.sp,
                          fontFamily: Font.inter)),
                  SizedBox(height: 40.h),
                  Container(
                    height: 70.h,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15.r,
                      ),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Column(
                            children: [
                              Text("Total Deposit",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: Font.inter,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400)),
                              getIt<TransactionViewModel>()
                                          .walletResponseModel
                                          ?.total_received ==
                                      null
                                  ? Text("0 Credits",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontFamily: Font.inter,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700))
                                  : Text(
                                      "${getIt<TransactionViewModel>().walletResponseModel!.total_received} Credits",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontFamily: Font.inter,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        const VerticalDivider(),
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Column(
                            children: [
                              Text("Total Spent",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: Font.inter,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400)),
                              getIt<TransactionViewModel>()
                                          .walletResponseModel
                                          ?.total_spent ==
                                      null
                                  ? Text("0 Credits",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontFamily: Font.inter,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700))
                                  : Text(
                                      "${getIt<TransactionViewModel>().walletResponseModel!.total_spent} Credits",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontFamily: Font.inter,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomButton(
                    onPressed: () {
                      getIt<AppRouter>().push(const WalletDeposit());
                    },
                    height: 65.h,
                    bgColor: Colors.white,
                    width: MediaQuery.sizeOf(context).width,
                    borderRadius: BorderRadius.circular(10.r),
                    child: Text("Deposit",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: Font.inter,
                            color: const Color(0xFFEC5873),
                            fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),

                  // )
                ],
              ),
            ),
          ));
    });
  }
}
