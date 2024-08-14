import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/model/produc_response.dart';
import 'package:organicbazzar/app/repository/latest_product_Repository.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class LatestProductController extends GetxController {
  var productLoading = false.obs;
  var isItems = false.obs;

  final latestProductRepository = Get.put(ProductRepository());
  final Rx<ApiResponse<List<ProductResponse>>> latestItemResponse =
      ApiResponse<List<ProductResponse>>.initial().obs;

  @override
  void onInit() {
    super.onInit();
    getLatestItems();
  }

  Future<void> getLatestItems() async {
    try {
      log('thii s the latest api call ');
      isItems(false);
      productLoading(true);
      latestItemResponse.value = ApiResponse<List<ProductResponse>>.loading();
      final itemsResult = await latestProductRepository.getProducts('LATEST');

      if (itemsResult.status == ApiStatus.SUCCESS) {
        final products = itemsResult.response!;
        latestItemResponse.value =
            ApiResponse<List<ProductResponse>>.completed(products);

        if (products.isNotEmpty) {
          isItems(true);
        } else {
          isItems(false);
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
      isItems(false);
    }
  }
}
