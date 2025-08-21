// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/core/failure/app_failure.dart';
import 'package:ofwhich_v2/domain/feed/feed_service.dart';
import 'package:ofwhich_v2/domain/feed/model/draft_model.dart';
import 'package:ofwhich_v2/domain/feed/model/feed_model.dart';
import 'package:ofwhich_v2/domain/feed/model/feed_post_model.dart';
import 'package:ofwhich_v2/domain/http_service/http_service.dart';
import 'package:ofwhich_v2/infrastructure/core/path.dart';

@LazySingleton(as: FeedService)
class IFeedRepo implements FeedService {
  final IHttpService httpService;

  IFeedRepo(this.httpService);
  @override
  Future<Either<AppFailure, FeedsModel>> getUserContentFeed() async {
    final failureOrSuccessOption =
        await httpService.getData(path: Paths.getUserContennt);

    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      FeedsModel feeds = FeedsModel.fromMap(r.value["data"]);
      return right(feeds);
    });
  }

  @override
  Future<Either<AppFailure, FeedsModel>> loadMore(
      {required String url, int? pageCount}) async {
    final failureOrSuccessOption = await httpService.getData(path: url);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      FeedsModel feeds = FeedsModel.fromMap(r.value["data"]);
      return right(feeds);
    });
  }

  @override
  Future<Either<AppFailure, FeedsModel>> getUserFeed() async {
    final failureOrSuccessOption =
        await httpService.getData(path: Paths.getUserPostFeed);

    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      FeedsModel feeds = FeedsModel.fromMap(r.value["data"]);
      return right(feeds);
    });
  }

  @override
  Future<Either<AppFailure, Unit>> likePost({required int? post_id}) async {
    var payload = {"post_id": post_id};
    final failureOrSuccessOption =
        await httpService.post(payload: payload, path: Paths.likePost);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      return right(unit);
    });
  }

  @override
  Future<Either<AppFailure, Unit>> unlikePost(
      {required int post_id, required int like_id}) async {
    var payload = {"post_id": post_id, "like_id": like_id};
    final failureOrSuccessOption =
        await httpService.post(payload: payload, path: Paths.unlikePost);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      return right(unit);
    });
  }

  @override
  Future<Either<AppFailure, String>> comment(
      {required int post_id, required String comment}) async {
    var payload = {"post_id": post_id, "comment": comment};
    final failureOrSuccessOption =
        await httpService.post(payload: payload, path: Paths.comment);

    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      String message = r.value['message'];
      return right(message);
    });
  }

  @override
  Future<Either<AppFailure, FeedPostModel>> findPost(
      {required int postId}) async {
    final failureOrSuccessoption =
        await httpService.getData(path: Paths.findPost + postId.toString());
    return failureOrSuccessoption.fold((l) {
      return left(l);
    }, (r) {
      FeedPostModel post = FeedPostModel.fromMap(r.value["data"]);
      return right(post);
    });
  }

  @override
  Future<Either<AppFailure, List<DraftModel>>> getDraft() async {
    final failureOrSuccessOption =
        await httpService.getData(path: Paths.findDrafts);
    return failureOrSuccessOption.fold((l) {
      return left(l);
    }, (r) {
      List<DraftModel> listData = List.from(
          r.value["data"]["drafts"]!.map((e) => DraftModel.fromMap(e)));
      return right(listData);
    });
  }
}
