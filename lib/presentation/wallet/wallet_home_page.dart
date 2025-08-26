// import 'package:flutter/foundation.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/transaction/transaction_view_model.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_button.dart';
import 'package:ofwhich_v2/presentation/wallet/widgets/transaction_bottom_sheet.dart';
// import 'package:ofwhich_v2/presentation/wallet/model/wallet_transaction_model.dart' as walletTrn;
import 'package:provider/provider.dart';

import '../../injectable.dart';
import '../core/font.dart';
import '../general_widgets/custom_appbar.dart';

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
          appBar: const OfWhichAppBar(
            titleText: "Wallet",
          ),
          // bottomSheet: const TransactionBottomSheet(),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
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
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Total Balance",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.white,
                                    size: 23,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "\$9,000",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 31.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomButton(
                                height: 60.h,
                                borderRadius: BorderRadius.circular(15.r),
                                borderColor: Colors.white.withOpacity(0.3),
                                bgColor: Colors.transparent,
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => ChooseLocationScreen(
                                  //         profile: profile,
                                  //       ),
                                  //     ));
                                },
                                child: Text("Send",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontFamily: Font.inter,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: CustomButton(
                                height: 60.h,
                                borderRadius: BorderRadius.circular(15.r),
                                bgColor: Colors.transparent,
                                borderColor: Colors.white.withOpacity(0.3),
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => ChooseLocationScreen(
                                  //         profile: profile,
                                  //       ),
                                  //     ));
                                },
                                child: Text(
                                  "Top up",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontFamily: Font.inter,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 70.h,
                  //   width: MediaQuery.sizeOf(context).width,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(
                  //       15.r,
                  //     ),
                  //     border: Border.all(color: Colors.grey[400]!),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.all(8.0.w),
                  //         child: Column(
                  //           children: [
                  //             Text(
                  //               "Total Deposit",
                  //               style: TextStyle(
                  //                   fontSize: 12.sp,
                  //                   fontFamily: Font.inter,
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.w400),
                  //             ),
                  //             getIt<TransactionViewModel>()
                  //                         .walletResponseModel
                  //                         ?.total_received ==
                  //                     null
                  //                 ? Text("0 Credits",
                  //                     style: TextStyle(
                  //                         fontSize: 18.sp,
                  //                         fontFamily: Font.inter,
                  //                         color: Colors.white,
                  //                         fontWeight: FontWeight.w700))
                  //                 : Text(
                  //                     "${getIt<TransactionViewModel>().walletResponseModel!.total_received} Credits",
                  //                     style: TextStyle(
                  //                         fontSize: 18.sp,
                  //                         fontFamily: Font.inter,
                  //                         color: Colors.white,
                  //                         fontWeight: FontWeight.w700)),
                  //           ],
                  //         ),
                  //       ),
                  //       const VerticalDivider(),
                  //       Padding(
                  //         padding: EdgeInsets.all(8.0.w),
                  //         child: Column(
                  //           children: [
                  //             Text("Total Spent",
                  //                 style: TextStyle(
                  //                     fontSize: 12.sp,
                  //                     fontFamily: Font.inter,
                  //                     color: Colors.white,
                  //                     fontWeight: FontWeight.w400)),
                  //             getIt<TransactionViewModel>()
                  //                         .walletResponseModel
                  //                         ?.total_spent ==
                  //                     null
                  //                 ? Text("0 Credits",
                  //                     style: TextStyle(
                  //                         fontSize: 18.sp,
                  //                         fontFamily: Font.inter,
                  //                         color: Colors.white,
                  //                         fontWeight: FontWeight.w700))
                  //                 : Text(
                  //                     "${getIt<TransactionViewModel>().walletResponseModel!.total_spent} Credits",
                  //                     style: TextStyle(
                  //                         fontSize: 18.sp,
                  //                         fontFamily: Font.inter,
                  //                         color: Colors.white,
                  //                         fontWeight: FontWeight.w700)),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // CustomButton(
                  //   onPressed: () {
                  //     getIt<AppRouter>().push(const WalletDeposit());
                  //   },
                  //   height: 65.h,
                  //   bgColor: Colors.red,
                  //   width: MediaQuery.sizeOf(context).width,
                  //   borderRadius: BorderRadius.circular(10.r),
                  //   child: Text("Deposit",
                  //       style: TextStyle(
                  //           fontSize: 16.sp,
                  //           fontFamily: Font.inter,
                  //           color: const Color(0xFFEC5873),
                  //           fontWeight: FontWeight.w400)),
                  // ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TransactionBottomSheet()
                  // )
                ],
              ),
            ),
          ));
    });
  }
}
