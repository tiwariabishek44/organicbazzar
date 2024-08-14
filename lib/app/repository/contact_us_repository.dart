// REPOSITORY TO SEND THE INQURY FOR THE PHYSICAL ITEMS

import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/contact_us_response.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class ContactUsRepository {
  Future<ApiResponse<ContactUsResponse>> inquiry(requesBody) async {
    final response = await ApiClient().postApi<ContactUsResponse>(
      ApiEndpoints.inquiryApi,
      requestBody: requesBody,
      isTokenRequired: true,
      responseType: (json) => ContactUsResponse.fromJson(json),
    );

    return response;
  }
}
