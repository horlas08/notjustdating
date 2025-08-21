// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:ofwhich_v2/domain/feed/model/feed_model.dart';

import '../core/failure/app_failure.dart';
import 'model/draft_model.dart';
import 'model/feed_post_model.dart';

abstract class FeedService {
  Future<Either<AppFailure, FeedsModel>> getUserContentFeed();
  Future<Either<AppFailure, FeedsModel>> loadMore(
      {required String url, int? pageCount});
  Future<Either<AppFailure, FeedsModel>> getUserFeed();
  Future<Either<AppFailure, Unit>> likePost({required int? post_id});
  Future<Either<AppFailure, Unit>> unlikePost(
      {required int post_id, required int like_id});
  Future<Either<AppFailure, String>> comment(
      {required int post_id, required String comment});
  Future<Either<AppFailure, FeedPostModel>> findPost({required int postId});
  Future<Either<AppFailure, List<DraftModel>>> getDraft();
}
