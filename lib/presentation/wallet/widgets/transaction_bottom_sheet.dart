import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/transaction/transaction_view_model.dart';
import 'package:provider/provider.dart';

import '../../../domain/transaction/models/wallet_transaction_model.dart';
import '../../../injectable.dart';
import '../../core/font.dart';
import '../wallet_home_page.dart';
import 'wallet_transaction_card.dart';

class TransactionBottomSheet extends StatefulWidget {
  const TransactionBottomSheet({
    super.key,
  });

  @override
  State<TransactionBottomSheet> createState() => _TransactionBottomSheetState();
}

class _TransactionBottomSheetState extends State<TransactionBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 tabs
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
      return Container(
        height: MediaQuery.sizeOf(context).height * 0.5,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r))),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Theme.of(context).primaryColor.withOpacity(0.6),
              unselectedLabelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: Font.inter,
                  color: Colors.black),
              labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: Font.inter,
                  color: Theme.of(context).primaryColor),
              tabs: const [
                Tab(
                  text: 'All',
                ),
                Tab(
                  text: 'Received',
                ),
                Tab(
                  text: 'Spent',
                ),
              ],
            ),
            model.isBusy
                ? const CircularProgressIndicator()
                : SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.40,
                    child: TabBarView(controller: _tabController, children: [
                      model.walletResponseModel != null &&
                              model.walletResponseModel!.transactions.isEmpty
                          ? const Center(child: Text("No transactions"))
                          : SingleChildScrollView(
                              child: SizedBox(
                                // color: Colors.black,
                                height:
                                    MediaQuery.of(context).size.height * 0.38,
                                child: NotificationListener<ScrollNotification>(
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                    if (scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                      log("called");
                                      log("loadmore ${model.isLoadMoreRunning}");
                                      if (!model.isLoadMoreRunning) {
                                        model.loadMore();
                                      }
                                    }
                                    return false;
                                  },
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: model
                                                .walletResponseModel!
                                                .transactions
                                                .length,
                                            // shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              WalletTransactionModel
                                                  walletTrnx = model
                                                      .walletResponseModel!
                                                      .transactions[index]!;
                                              return WalletTransactionCard(
                                                  walletTrnx: walletTrnx);
                                            }),
                                      ),
                                      if (model.isLoadMoreRunning)
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child:
                                              const CircularProgressIndicator(),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      model.creditTransactions.isEmpty
                          ? const Center(child: Text("No transactions"))
                          : SingleChildScrollView(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.38,
                                child: NotificationListener<ScrollNotification>(
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                    if (scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                      log("called");
                                      log("loadmore ${model.isLoadMoreRunning}");
                                      if (!model.isLoadMoreRunning) {
                                        model.loadMore();
                                      }
                                    }
                                    return false;
                                  },
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount:
                                                model.creditTransactions.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              WalletTransactionModel
                                                  walletTrnx =
                                                  model.creditTransactions[
                                                      index]!;
                                              return WalletTransactionCard(
                                                  walletTrnx: walletTrnx);
                                            }),
                                      ),
                                      if (model.isLoadMoreRunning)
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child:
                                              const CircularProgressIndicator(),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      model.debitTransactions.isEmpty
                          ? const Center(child: Text("No transactions"))
                          : SingleChildScrollView(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.38,
                                child: NotificationListener<ScrollNotification>(
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                    if (scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                      log("called");
                                      log("loadmore ${model.isLoadMoreRunning}");
                                      if (!model.isLoadMoreRunning) {
                                        model.loadMore();
                                      }
                                    }
                                    return false;
                                  },
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount:
                                                model.debitTransactions.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              WalletTransactionModel
                                                  walletTrnx =
                                                  model.debitTransactions[
                                                      index]!;
                                              return WalletTransactionCard(
                                                  walletTrnx: walletTrnx);
                                            }),
                                      ),
                                      if (model.isLoadMoreRunning)
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child:
                                              const CircularProgressIndicator(),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ]),
                  )
          ],
        ),
      );
    });
  }
}