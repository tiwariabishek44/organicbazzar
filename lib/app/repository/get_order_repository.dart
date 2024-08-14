// REPOSITORY TO GET THE PHYSICAL ITEMS

import 'dart:developer';

import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/get_order_response.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class MyOrderRepository {
  final ApiClient _apiClient = ApiClient();

  Future<ApiResponse<GetOrderResponse>> getOrders(String orderStatus) async {
    try {
      // Fetch orders from the API using ApiClient
      ApiResponse<GetOrderResponse> response =
          await _apiClient.getApi<GetOrderResponse>(
        ApiEndpoints.getOrder,
        isTokenRequired: true,
        responseType: (json) => GetOrderResponse.fromJson(json),
      );

      return response;
    } catch (e) {
      return ApiResponse.error("Something went wrong. Please try again later");
    }
  }
}
