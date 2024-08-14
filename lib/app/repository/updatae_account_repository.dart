import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/common_response.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class UpdateACcountRepository {
  Future<ApiResponse<CommonResponse>> changePhone(
      bool isPhone, requesBody) async {
    final response = await ApiClient().postApi<CommonResponse>(
      isPhone ? ApiEndpoints.changePhoneNo : ApiEndpoints.changeAddress,
      requestBody: requesBody,
      isTokenRequired: true,
      responseType: (json) => CommonResponse.fromJson(json),
    );

    return response;
  }
}
