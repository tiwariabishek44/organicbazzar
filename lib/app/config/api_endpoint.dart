import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static final String baseUrl =
      dotenv.env['BASE_URL'] ?? 'https://default-url.com';

  static final String deviceRegistration =
      "$baseUrl/api/ecommerce/open/notifications/register-device";
  static final String registerPhase1 =
      "$baseUrl/api/ecommerce/open/accounts/create";
  static final String verifyOtp =
      "$baseUrl/api/ecommerce/open/accounts/verify-otp";
  static final String login = "$baseUrl/api/ecommerce/open/accounts/login";
  static final String forgetpassword2 =
      "$baseUrl/api/ecommerce/open/accounts/reset-password";
  static final String forgetpassword1 =
      "$baseUrl/api/ecommerce/open/accounts/initiate-reset-password";
  static final String refreshAccessToken =
      "$baseUrl/api/ecommerce/open/accounts/refresh-access-token";
  static final String getUserData =
      "$baseUrl/api/ecommerce/user/get-my-account";
  static final String changePhoneNo =
      "$baseUrl/api/ecommerce/user/update-account-phone";
  static final String changeAddress =
      "$baseUrl/api/ecommerce/user/update-account-address";
  static final String makeOrder = "$baseUrl/api/ecommerce/user/add-order";
  static final String getOrder = "$baseUrl/api/ecommerce/user/get-all-orders";
  static final String cancelOrder = "$baseUrl/api/ecommerce/user/cancel-order";
  static final String inquiryApi = "$baseUrl/api/open/common/sales/add-inquiry";
  static final String getProduct = "$baseUrl/api/ecommerce/open/product/all";
}
