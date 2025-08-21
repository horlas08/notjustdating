import 'package:dartz/dartz.dart';
import 'package:ofwhich_v2/domain/transaction/models/subscription_response_model.dart';

import '../core/failure/app_failure.dart';
import 'models/wallet_response_model.dart';

abstract class TransactionService {
  Future<Either<AppFailure, SubbscriptionResponseModel>> subscribe(
      {required String plan, required String paymentMethod});
  Future<Either<AppFailure, String>> successStatus(
      {required String referenceId});

  Future<Either<AppFailure, WalletResponseModel>> getWalletTransactions(
      {required int pageNumber});

  Future<Either<AppFailure, WalletResponseModel>> loadMore(
      {required String url, int? pageCount});
  Future<Either<AppFailure, String>> updateWallet({required num amount});
}
