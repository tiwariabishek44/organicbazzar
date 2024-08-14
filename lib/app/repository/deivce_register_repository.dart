import 'dart:developer';

import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/device_registration.dart';
import 'package:organicbazzar/app/model/login_api_response.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class DeviceRegistrationRepository {
  Future<ApiResponse<DeviceRegistrationResponse>> registerDevice(
      requesBody) async {
    final response = await ApiClient().postApi<DeviceRegistrationResponse>(
      ApiEndpoints.deviceRegistration,
      requestBody: requesBody,
      isTokenRequired: false,
      responseType: (json) => DeviceRegistrationResponse.fromJson(json),
    );

    return response;
  }
}
