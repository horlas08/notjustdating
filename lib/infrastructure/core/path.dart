class Paths {
  static const String register = "/register";
  static const String verifyEmail = "/user/verify";
  static const String updateDefaultPassword = "/user/change-default-password";
  static const String login = "/login";
  static const String profileUpdate = "/user/profile/update";
  static const String resentOtp = "/user/otp/resend";
  static const String getUserProfile = "/user/profile";
  static const String getFeed = "/user/feeds?";
  static const String likeUser = "/user/feeds/store/like";
  static const String uploadPhoto = "/user/profile/picture/upload";
  static const String createPost = "/content-creator/posts/upload";
  static const String createDraft = "/content-creator/drafts/upload";
  static const String getLocations = "/locations/get";
  static const String getUser = "/user/list?pagination_count=";
  static const String getUserContennt = "/content-creator/posts";
  static const String getUserPostFeed = "/user/feeds/posts";
  static const String likePost = "/activity/post/like";
  static const String unlikePost = "/activity/post/unlike";
  static const String comment = "/activity/post/comment";
  static const String getMatchedUsers = "/user/feeds/matched/get";
  static const String findPost = "/post/find/";
  static const String findDrafts = "/content-creator/drafts";
  static const String getGroups = "/group/list";
  static const String getUserGroups = "/user/group/list";
  static const String addMember = "/user/group/attach";
  static const String listwithoutsdk = '/group/listwithoutsdk';
  static const String updateSdkId = "/group/attach-sdk-id";
  static const String storeSDKChatHistory = "/user/chat/store-sdk-chat-history";
  static const String checkHistory = "/user/chat/check-history?";
  static const String updateUserInterest = "/user/profile/interest/update";
  static const String getProfileLikes = "/user/feeds/unmatched/profile/likes";
  static const String reportMessage = "/user/report-user/store";
  static const String getGifts = "/gift/list";
  static const String sendGift = "/user/wallet/balance/update";

  static const String storeDate = "/user/date/requests/store";

  static const String updateDatePayment = "/user/payment/successful";
  static const String rejectDate = "/user/date/requests/reject";

  static const String fetchDateRequests = "/user/date/requests/list";
  static const String subscribbe = "/user/subscribe";
  static const String paymenntSuccess = "/user/payment/successful";
  static const String getWalletTransaction = "/user/gift/transaction?";
  static const String updateUserWallet = "/user/wallet/balance/update";
}

//https://ofwhich.com/api/user/report-user/store