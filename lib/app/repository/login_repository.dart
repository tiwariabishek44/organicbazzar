import 'dart:developer';

import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/login_api_response.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class LoginRepository {
//------------USER  LOGIN
  Future<ApiResponse<LoginApiResponse>> loginUser(requesBody) async {
    log(" INSIDE THE LOGIN REPOSITORY");
    final response = await ApiClient().postApi<LoginApiResponse>(
      ApiEndpoints.login,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => LoginApiResponse.fromJson(json),
    );

    return response;
  }
}
