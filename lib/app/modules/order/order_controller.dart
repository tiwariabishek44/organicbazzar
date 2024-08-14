// TO DISPLAY THE LIST OF THE PHYSICAL ITEMS

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/model/get_order_response.dart';
import 'package:organicbazzar/app/model/my_order_response.dart';
import 'package:organicbazzar/app/model/produc_response.dart';
import 'package:organicbazzar/app/repository/get_order_repository.dart';
import 'package:organicbazzar/app/repository/latest_product_Repository.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class MyOrderController extends GetxController {
  var orderLoading = false.obs;
  var isItems = false.obs;
  //--------------Get physical items------------------

  @override
  void onInit() async {
    super.onInit();
    getOrders();
  }

  final myOrderRepository = Get.put(MyOrderRepository());

  final Rx<ApiResponse<GetOrderResponse>> myOrderResponse =
      ApiResponse<GetOrderResponse>.initial().obs;
  Future<void> getOrders() async {
    log('getting the orders');
    try {
      isItems(false);

      orderLoading(true);
      myOrderResponse.value = ApiResponse<GetOrderResponse>.loading();
      final itemsResult = await myOrderRepository.getOrders('ORDERED');
      if (itemsResult.status == ApiStatus.SUCCESS) {
        myOrderResponse.value =
            ApiResponse<GetOrderResponse>.completed(itemsResult.response);
        if (myOrderResponse.value.response!.data.length > 0) {
          orderLoading(false);
          isItems(true);
        }

        orderLoading(false);
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.primaryColor,
            content: Text(itemsResult.message.toString()),
          ),
        );
        log("${itemsResult.message}");
        isItems(false);
        orderLoading(false);
      }
    } catch (e) {
      log("${e.toString()}");

      orderLoading(false);
    }
  }
}
