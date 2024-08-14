import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/otp_response.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class OtpVerifyRepository {
  Future<ApiResponse<OtpResponse>> verifyOtp(requesBody) async {
    final response = await ApiClient().postApi<OtpResponse>(
      ApiEndpoints.verifyOtp,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => OtpResponse.fromJson(json),
    );

    return response;
  }
}
