import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/forget_password_response.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class ForgetPasswordRepository {
  //--------FORGET PASSWORD FIRST STEP -SENDING OTP
  Future<ApiResponse<ForgetPasswordResponse>> firstStep(requesBody) async {
    final response = await ApiClient().postApi<ForgetPasswordResponse>(
      ApiEndpoints.forgetpassword1,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => ForgetPasswordResponse.fromJson(json),
    );

    return response;
  }

  //-----------FORGET PASSWORD SECOND STEP --- NEW PASSWORD CHANGING

  Future<ApiResponse<ForgetPasswordResponse>> secondStep(requesBody) async {
    final response = await ApiClient().postApi<ForgetPasswordResponse>(
      ApiEndpoints.forgetpassword2,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => ForgetPasswordResponse.fromJson(json),
    );

    return response;
  }
}
