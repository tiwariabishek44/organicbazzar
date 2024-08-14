import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/model/produc_response.dart';
import 'package:organicbazzar/app/repository/latest_product_Repository.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class OurProductController extends GetxController {
  var productLoading = false.obs;
  var isItems = false.obs;

  @override
  void onInit() {
    super.onInit();
    getRegularProducts();
  }

  final productRepository = Get.put(ProductRepository());

  final Rx<ApiResponse<List<ProductResponse>>> physicalItemresponse =
      ApiResponse<List<ProductResponse>>.initial().obs;
  Future<void> getRegularProducts() async {
    try {
      isItems(false);

      productLoading(true);
      physicalItemresponse.value = ApiResponse<List<ProductResponse>>.loading();
      final itemsResult = await productRepository.getProducts('REGULAR');
      if (itemsResult.status == ApiStatus.SUCCESS) {
        final products = itemsResult.response!;

        physicalItemresponse.value =
            ApiResponse<List<ProductResponse>>.completed(itemsResult.response);

        if (products.length >= 0) {
          isItems(true);
        }
        productLoading(false);
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.primaryColor,
            content: Text(itemsResult.message.toString()),
          ),
        );
        log("${itemsResult.message}");
        isItems(false);
        productLoading(false);
      }
    } catch (e) {
      log("${e.toString()}");

      productLoading(false);
    }
  }
}
