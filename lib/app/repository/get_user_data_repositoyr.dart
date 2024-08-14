import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/user_data_response.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class GetUserDataRepository {
  Future<ApiResponse<UserDataResponse>> getUserData() async {
    final response = await ApiClient().getApi<UserDataResponse>(
      ApiEndpoints.getUserData,
      isTokenRequired: true,
      responseType: (json) => UserDataResponse.fromJson(json),
    );

    return response;
  }
}
