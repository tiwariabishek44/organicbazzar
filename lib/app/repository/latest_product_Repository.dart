import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/produc_response.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class ProductRepository {
  Future<ApiResponse<List<ProductResponse>>> getProducts(String filter) async {
    final response = await ApiClient().getApi<List<ProductResponse>>(
      ApiEndpoints.getProduct,
      isTokenRequired: false,
      responseType: (json) => (json as List)
          .map((item) => ProductResponse.fromJson(item))
          .where((product) => product.productType == filter)
          .toList(),
    );

    return response;
  }
}
