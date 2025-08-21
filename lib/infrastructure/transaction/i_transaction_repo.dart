import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/core/failure/app_failure.dart';
import 'package:ofwhich_v2/domain/http_service/http_service.dart';
import 'package:ofwhich_v2/domain/transaction/models/subscription_response_model.dart';
import 'package:ofwhich_v2/domain/transaction/models/wallet_response_model.dart';
import 'package:ofwhich_v2/domain/transaction/transaction_service.dart';
// import 'package:ofwhich_v2/presentation/wallet/model/wallet_transaction_model.dart';

import '../core/path.dart';

@LazySingleton(as: TransactionService)
class ITransactionRepo implements TransactionService {
  final IHttpService _httpService;

  ITransactionRepo({required IHttpService httpService})
      : _httpService = httpService;
  @override
  Future<Either<AppFailure, SubbscriptionResponseModel>> subscribe(
      {required String plan, required String paymentMethod}) async {
    var payload = {"plan": plan, "payment_method": paymentMethod};
    final failureOrSuccessOption =
        await _httpService.post(payload: payload, path: Paths.subscribbe);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      SubbscriptionResponseModel sub =
          SubbscriptionResponseModel.fromMap(r.value['data']);
      return right(sub);
    });
  }

  @override
  Future<Either<AppFailure, String>> successStatus(
      {required String referenceId}) async {
    var payload = {"reference_id": referenceId};
    final failureOrSuccssOtion =
        await _httpService.post(payload: payload, path: Paths.paymenntSuccess);
    return failureOrSuccssOtion.fold((l) {
      return left(l);
    }, (r) {
      return right(r.value["message"]);
    });
  }

  @override
  Future<Either<AppFailure, WalletResponseModel>> getWalletTransactions(
      {required int pageNumber}) async {
    final failureOrSuccessOption = await _httpService.getData(
        path: "${Paths.getWalletTransaction}page=$pageNumber");
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      WalletResponseModel walletResponseModel =
          WalletResponseModel.fromMap(r.value['data']);

      // for test
      // WalletResponseModel walletResponseModel =
      //     WalletResponseModel.fromMap(data['data']!);
      return right(walletResponseModel);
    });
  }

  @override
  Future<Either<AppFailure, WalletResponseModel>> loadMore(
      {required String url, int? pageCount}) async {
    final failureOrSuccessOption = await _httpService.getData(path: url);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      WalletResponseModel walletResponseModel =
          WalletResponseModel.fromMap(r.value["data"]);
      return right(walletResponseModel);
    });
  }

  @override
  Future<Either<AppFailure, String>> updateWallet({required num amount}) async {
    var payload = {"amount": amount};
    final failureOrSuccessOption =
        await _httpService.post(payload: payload, path: Paths.updateUserWallet);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      String message = r.value["message"];
      return right(message);
    });
  }
}
