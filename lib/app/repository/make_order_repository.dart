// // repo to make order calling the apiclient to make the order

// import 'dart:developer';

// import 'package:organicbazzar/app/config/api_endpoint.dart';
// import 'package:organicbazzar/app/model/login_api_response.dart';
// import 'package:organicbazzar/app/model/order_response_model.dart';
// import 'package:organicbazzar/app/service/api_client.dart';

// class MakeOrderRepository {
//   Future<ApiResponse<OrderResponseModel>> makeOrder(
//       List<Map<String, dynamic>> requestBody) async {
//     log("INSIDE THE MAKE ORDER REPOSITORY");
//     final response = await ApiClient().postApi<OrderResponseModel>(
//       ApiEndpoints.login,
//       requestBody: requestBody,
//       isTokenRequired: false,
//       responseType: (json) => OrderResponseModel.fromJson(json),
//     );

//     return response;
//   }
// }
