class UrlApi {
  static String register = "register";
  static String login = "login";
  static String verifyOtp = "otp/verifikasi-otp";
  static String logout = "user/logout";

  // USER
  static String createUserDetails = "user/create-user-details";
  static String getUserDetails = "user/get-user-by-email";
  static String updateUserDetails = "user/edit-user-details";
  static String updateUserDetailsImage = "user/edit-user-details-image";

  // ITEM
  static String getItem = "item/get-item";
  static String createItem = "item/create-item";

  // ORDER
  static String getOrderByStatus = "order/get-order-status";
  static String receiveOrder = "order/terima-order";
  static String finishOrder = "order/finish-order";
}
