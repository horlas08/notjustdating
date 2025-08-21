import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/transaction/models/wallet_response_model.dart';
import 'package:ofwhich_v2/domain/transaction/transaction_service.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';

import '../../domain/core/constants/error_messages.dart';
import '../../domain/transaction/models/wallet_transaction_model.dart';
import '../../infrastructure/core/path.dart';
import '../../infrastructure/handler/snack_bar_handler.dart';
import '../../presentation/routes/app_router.dart';

@LazySingleton()
class TransactionViewModel extends ChangeNotifier {
  final TransactionService transactionService;
  WalletResponseModel? walletResponseModel;
  final SnackbarHandler snackbarHandlerImpl;
  TransactionViewModel(this.transactionService, this.snackbarHandlerImpl);

  bool isBusy = false;

  setBusy(val) {
    isBusy = val;
    notifyListeners();
  }

  getWalletTransactions({required int pageNumber}) async {
    setBusy(true);
    final result =
        await transactionService.getWalletTransactions(pageNumber: pageNumber);

    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl.showErrorSnackbar(l.message!);
    }, (r) {
      setBusy(false);
      log("loadmoreeee::::" + isLoadMoreRunning.toString());
      walletResponseModel = r;
      if (walletResponseModel != null) {
        getCreditTransaction();
        getDebitTransaction();
      }
      notifyListeners();
    });
  }

  bool isFirstRunLoading = false;
  bool hasNextPage = true;
  bool isLoadMoreRunning = false;
  int pageNumber = 1;
  Future<void> loadMore() async {
    if (isFirstRunLoading || isLoadMoreRunning || !hasNextPage) return;

    try {
      isLoadMoreRunning = true;
      notifyListeners();

      pageNumber++;

      if (walletResponseModel?.next_page_url == null ||
          walletResponseModel!.next_page_url!.isEmpty) {
        hasNextPage = false;
        isLoadMoreRunning = false;
        notifyListeners();
        return;
      }

      final result = await transactionService.loadMore(
          url: "${Paths.getWalletTransaction}page=$pageNumber");

      result.fold((failure) {
        isLoadMoreRunning = false;
        hasNextPage = false;
        notifyListeners();
        snackbarHandlerImpl.showErrorSnackbar(
            failure.message ?? ErrorMessages().serverErrorString);
      }, (success) {
        List<WalletTransactionModel?> transactions = success.transactions;

        if (transactions.isEmpty) {
          hasNextPage = false;
        } else {
          walletResponseModel!.transactions.addAll(transactions);
        }

        isLoadMoreRunning = false;
        notifyListeners();
      });
    } catch (e) {
      isLoadMoreRunning = false;
      hasNextPage = false;
      notifyListeners();
    }
  }

  List<WalletTransactionModel?> creditTransactions = [];
  getCreditTransaction() {
    creditTransactions = walletResponseModel!.transactions
        .where((element) => element != null && element.type == "credit")
        .toList();
    notifyListeners();
  }

  List<WalletTransactionModel?> debitTransactions = [];
  getDebitTransaction() {
    debitTransactions = walletResponseModel!.transactions
        .where((element) => element != null && element.type == "debit")
        .toList();
    notifyListeners();
  }

  updateUserWallet({required num amount}) async {
    setBusy(true);
    final result = await transactionService.updateWallet(amount: amount);

    return result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      setBusy(false);
      // getIt<AppRouter>().push(DatePaymentWebViewPage(
      //     paymentData: paymentData, paymentInitiatorType: ""));
      snackbarHandlerImpl.showSnackbar(r);
    });
  }
}
