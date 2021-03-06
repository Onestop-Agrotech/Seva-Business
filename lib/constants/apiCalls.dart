class APIService {
  static final String _sevaApi = "https://api.theonestop.co.in/api";

  // BUSINESSES
  static final String loginMobile = "$_sevaApi/businesses/loginMobile/";
  static final String verifyOTP = "$_sevaApi/businesses/loginMobile/verifyOTP/";
  static final String businessProductsListAPI = "$_sevaApi/businesses/";
  static final String ordersListAPI = "$_sevaApi/orders/business/";

  static final String businessNameAPI = "$_sevaApi/businesses/storeName/";
  static final String productsTypeAPI =
      "$_sevaApi/businesses/storeProductType/";
  static final String businessOnline = "$_sevaApi/businesses/online/";

  // ORDERS
  static final String confirmOrderAPI = "$_sevaApi/orders/confirm/order";

  // Firebase
  static final String setDeviceTokenInFirestore =
      "$_sevaApi/firestore/businesssettoken";

  // OTHERS
  // loading.dart - _sendReqToServer function
  static final String mainTokenAPI = "https://api.theonestop.co.in/token";
}
