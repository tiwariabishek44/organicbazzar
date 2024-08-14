// REPOSITOR TO REGISTER USER

import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/register_response_model.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class UserRegisterRepository {
  Future<ApiResponse<RegisterResponseModel>> registerUser(requesBody) async {
    final response = await ApiClient().postApi<RegisterResponseModel>(
      ApiEndpoints.registerPhase1,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => RegisterResponseModel.fromJson(json),
    );

    return response;
  }
}
