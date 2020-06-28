class APIService {
  static final String _sevaApi = "https://frozen-sands-29962.herokuapp.com/api";

  // BUSINESSES
  static final String loginMobile = "$_sevaApi/businesses/loginMobile/";
  static final String verifyOTP = "$_sevaApi/businesses/loginMobile/verifyOTP/";
  static final String businessProductsListAPI = "$_sevaApi/businesses/";
  static final String ordersListAPI = "$_sevaApi/orders/business/";

  // OTHERS
  // loading.dart - _sendReqToServer function
  static final String mainTokenAPI =
      "https://frozen-sands-29962.herokuapp.com/token";
}
