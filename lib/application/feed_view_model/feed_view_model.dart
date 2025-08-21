// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:developer';
// import 'dart:developer';
// import 'dart:html';

import 'package:injectable/injectable.dart';
import 'package:ofwhich_v2/domain/chat/chat_service.dart';
import 'package:ofwhich_v2/domain/core/constants/error_messages.dart';
import 'package:ofwhich_v2/domain/feed/feed_service.dart';
import 'package:ofwhich_v2/domain/feed/model/feed_model.dart';
import 'package:ofwhich_v2/domain/feed/model/feed_post_model.dart';
import 'package:ofwhich_v2/infrastructure/core/path.dart';
import 'package:stacked/stacked.dart';

import '../../domain/feed/model/draft_model.dart';
import '../../domain/user_service/model/user_object.dart';
import '../../infrastructure/handler/snack_bar_handler.dart';

// import '../../infrastructure/user/model/feed.dart';
// @lazySingleton
@injectable
class FeedViewModel extends BaseViewModel {
  final FeedService feedService;
  final SnackbarHandler snackbarHandlerImpl;
  final ChatService chatService;

  // final Aut
  FeedViewModel(this.snackbarHandlerImpl,
      {required this.feedService, required this.chatService});

  bool isFirstRunLoading = false;
  bool hasNextPage = true;
  bool isLoadMoreRunning = false;
  bool isLiked = false;
  bool isCommentedOn = false;
  bool isUserExploreFeedFirstRun = false;
  bool userExploreFeedhasNextPage = false;
  bool isUserExploreFeedLoadMoreRunning = false;

  List<FeedPostModel> userPost = [];
  List<FeedPostModel> userFeed = [];
  List<FeedPostModel> pendingPost = [];
  List<FeedPostModel> approvedPost = [];
  List<DraftModel> draftList = [];
  FeedsModel? feed;
  FeedsModel? userF;

  final _userPostFeedController = StreamController<List<FeedPostModel?>?>();

  Stream<List<FeedPostModel?>?> get userTransactionsListStream =>
      _userPostFeedController.stream;

  setFirstRunLoading({required bool value}) {
    isFirstRunLoading = value;
    notifyListeners();
  }

//content creator posts
  Future<void> getUserPosts() async {
    setBusy(false);
    final failureOrSuccessOptionn = await feedService.getUserContentFeed();
    return failureOrSuccessOptionn.fold((l) {
      setBusy(true);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      setBusy(false);
      feed = r as FeedsModel?;
      userPost = r.posts;
      _userPostFeedController.add(userPost);
      notifyListeners();
    });
  }

  int page1 = 1;
  Future<void> loadMoreFeed() async {
    if (isFirstRunLoading || isLoadMoreRunning || !hasNextPage) return;

    try {
      isLoadMoreRunning = true;
      page1++;
      notifyListeners();

      if (feed == null || feed!.next_page_url.isEmpty) {
        hasNextPage = false;
        isLoadMoreRunning = false;
        notifyListeners();
        return;
      }

      final failureOrSuccessOptionn = await feedService.loadMore(
          url: "${Paths.getUserContennt}?page=$page1");

      failureOrSuccessOptionn.fold((failure) {
        isLoadMoreRunning = false;
        hasNextPage = false;
        notifyListeners();
        snackbarHandlerImpl.showErrorSnackbar(
            failure.message ?? ErrorMessages().serverErrorString);
      }, (success) {
        List<FeedPostModel> moreFeed = success.posts;

        if (moreFeed.isEmpty) {
          hasNextPage = false;
        } else {
          userPost.addAll(moreFeed);
          hasNextPage = true;
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

//explore feed
  void getUserFeed() async {
    setBusy(false);
    final failureOrSuccessOptionn = await feedService.getUserFeed();
    return failureOrSuccessOptionn.fold((l) {
      setBusy(true);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      setBusy(false);
      userF = r as FeedsModel?;
      userFeed = r.posts;
      log("userFeed::::::$userFeed");
      // _userPostFeedController.add(userPost);
      notifyListeners();
    });
  }

  int userExploreFeedpage1 = 1;
  loadMoreUserExploreFeed() async {
    if (!isUserExploreFeedFirstRun) {
      if (userExploreFeedhasNextPage && !isUserExploreFeedLoadMoreRunning) {
        isUserExploreFeedLoadMoreRunning = true;
        page1++;
        notifyListeners();
        if (feed != null && feed!.next_page_url.isNotEmpty) {
          final failureOrSuccessOptionn = await feedService.loadMore(
              url: "${Paths.getUserContennt}?page=$page1");

          return failureOrSuccessOptionn.fold((l) {
            snackbarHandlerImpl.showErrorSnackbar(
                l.message ?? ErrorMessages().serverErrorString);
          }, (r) {
            List<FeedPostModel> moreFeed = r.posts;
            if (moreFeed.isEmpty) {
              userExploreFeedhasNextPage = false;
              isUserExploreFeedLoadMoreRunning = false;

              // moreBeneficiary = userBeneficiariesModel!.data!;
              notifyListeners();
            } else {
              userFeed.addAll(moreFeed);
              isUserExploreFeedLoadMoreRunning = false;
              userExploreFeedhasNextPage = true;

              notifyListeners();
            }
          });
        }
      }
    } else if (!userExploreFeedhasNextPage) {
      return;
    }
  }

  bool isVideo({required String link}) {
    if (link.endsWith(".mp4") || link.contains(".mp4")) {
      return true;
    } else {
      return false;
    }
  }

  // Future<void> likeAPost(
  //     {required int post_id, required List<UserModelForPost> users}) async {
  //   setBusy(true);
  //   final failureOrSuccessOption = await feedService.likePost(post_id: post_id);

  //   return failureOrSuccessOption.fold((l) {
  //     setBusy(false);
  //     snackbarHandlerImpl
  //         .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
  //   }, (r) async {
  //     final failureOrSuccessOptionn = await feedService.getUserContentFeed();
  //     failureOrSuccessOptionn.fold((l) {
  //       setBusy(false);
  //       snackbarHandlerImpl
  //           .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
  //     }, (r) {
  //       setBusy(false);
  //       feed = r as FeedsModel?;
  //       userPost = r.posts;
  //       _userPostFeedController.add(userPost);
  //       notifyListeners();
  //     });
  //     checkIfLiked(users: users);
  //   });
  // }

  UserModel? user;
  // // UserModel user => _chatService.getSavedUser();

  // getSavedUaser() async {
  //   user = await chatService.getSavedUser();
  //   notifyListeners();
  // }

  // void checkIfLiked({required List<UserModelForPost> users}) async {
  //   var user = await chatService.getSavedUser();
  //   // if (user != null) {
  //   var userId =
  //       users.firstWhere((element) => element.id == user.id, orElse: () {
  //     return UserModelForPost(full_name: "N/A", id: -1);
  //   });
  //   isLiked = userId.id != -1;

  //   notifyListeners();
  // }

  Future<bool> likeAPost(
      {required int post_id, required List<UserModelForPost> users}) async {
    bool response = false;
    setBusy(true);
    final failureOrSuccessOption = await feedService.likePost(post_id: post_id);

    await failureOrSuccessOption.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
      response = false;
      notifyListeners();
    }, (r) async {
      await getUserPosts();

      var post = userPost.firstWhere((element) => element.id == post_id);
      response = await checkIfLiked(users: post.likes.users, postId: post_id);
      // });
      // response = true;
      notifyListeners();
    });

    return response;
  }

  Future<void> getSavedUser() async {
    user = await chatService.getSavedUser();
    notifyListeners();
    // rebuildUi();
  }

  Future<bool> checkIfLiked(
      {List<UserModelForPost>? users, int? postId}) async {
    var post =
        userPost.firstWhere((element) => element.id == postId, orElse: () {
      return FeedPostModel(
          id: -1,
          user_id: -1,
          file_name: "",
          comment: "",
          location_id: -1,
          tagged_people: [],
          is_public: 0,
          comments: Comments(comment_id: -1, users: []),
          likes: Likes(users: []));
    });
    await getSavedUser();
    if (user != null) {
      var userId = post.likes.users
          .firstWhere((element) => element.user_id == user!.id, orElse: () {
        return UserModelForPost(full_name: "N/A", user_id: -1);
      });
      isLiked = userId.user_id != -1;
      notifyListeners();
    }
    return isLiked;
  }

  Future<void> checkIfCommentedOn(
      {required List<UserModelForPost> users}) async {
    await getSavedUser();
    if (user != null) {
      var userId = users.firstWhere((element) => element.user_id == user!.id,
          orElse: () {
        return UserModelForPost(full_name: "N/A", user_id: -1);
      });

      isCommentedOn = userId.user_id != -1;
      notifyListeners();
    }
  }

  Future<bool> unlikePost(
      {required int post_id, required List<UserModelForPost> users}) async {
    bool response = false;
    setBusy(true);
    var user = await chatService.getSavedUser();
    // if (user != null) {
    var userId =
        users.firstWhere((element) => element.user_id == user.id, orElse: () {
      return UserModelForPost(full_name: "N/A", user_id: -1);
    });

    final failureOrSuccessOption = await feedService.unlikePost(
        post_id: post_id, like_id: userId.like_id ?? 1);
    // log("loggeddddddd");
    await failureOrSuccessOption.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
      response = false;
      notifyListeners();
    }, (r) async {
      await getUserPosts();
      // checkIfLiked(users: users);
      // final failureOrSuccessOptionn = await feedService.getUserContentFeed();
      // failureOrSuccessOptionn.fold((l) {
      //   setBusy(false);
      //   snackbarHandlerImpl
      //       .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
      // }, (r) async {
      //   setBusy(false);
      //   feed = r as FeedsModel?;
      //   userPost = r.posts;
      //   _userPostFeedController.add(userPost);
      //   notifyListeners();
      var post = userPost.firstWhere((element) => element.id == post_id);

      response = await checkIfLiked(users: post.likes.users, postId: post_id);
      // });
    });
    return response;
  }

  Future<void> comment({required int post_id, required String comment}) async {
    setBusy(true);
    final result =
        await feedService.comment(post_id: post_id, comment: comment);
    await result.fold((l) {
      setBusy(false);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) async {
      setBusy(false);
      // String message = r;
      notifyListeners();
      await getPost(postId: post_id);
      // await checkIfCommentedOn()
    });
  }

  final StreamController<List<UserModelForPost>> _commentsStreamController =
      StreamController<List<UserModelForPost>>.broadcast();

  // Getter for the stream
  Stream<List<UserModelForPost>> get commentStrean =>
      _commentsStreamController.stream;
  FeedPostModel? postModel;
  Future<void> getPost({required int postId}) async {
    final failureOrSuccessOption = await feedService.findPost(postId: postId);
    failureOrSuccessOption.fold((l) {
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      postModel = r;

      _commentsStreamController.sink.add(postModel!.comments.users);
      notifyListeners();
    });
  }

  String extractUrlUpToMp4(String url) {
    // Find the index of ".mp4"
    int index = url.indexOf('.mp4');

    // Extract the substring from the start of the URL up to and including ".mp4"
    if (index != -1) {
      return url.substring(0, index + 4);
    } else {
      // If ".mp4" is not found, return the original URL
      return url;
    }
  }

  sortUserPost() {
    pendingPost =
        userPost.where((element) => element.status == "pending").toList();
    log("fiwpfiwefwpewnefwiefnwefwewfwfwwoewe  ::::::: ${pendingPost.length}");
    notifyListeners();
  }

  sortApprovedPost() {
    approvedPost =
        userPost.where((element) => element.status == "approved").toList();
    notifyListeners();
  }

  void getDrafts() async {
    setBusy(false);
    final failureOrSuccessOptionn = await feedService.getDraft();
    return failureOrSuccessOptionn.fold((l) {
      setBusy(true);
      snackbarHandlerImpl
          .showErrorSnackbar(l.message ?? ErrorMessages().serverErrorString);
    }, (r) {
      setBusy(false);

      draftList = r;
      log(" wpmsfmwepfwmwpfmwewpem :::::::::${draftList.length}");
      // _userPostFeedController.add(userPost);
      notifyListeners();
    });
  }
}
