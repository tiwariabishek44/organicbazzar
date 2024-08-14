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

class OrderHistoryController extends GetxController {
  var orderLoading = false.obs;
  var isItems = false.obs;
  //--------------Get physical items------------------

  final myOrderRepository = Get.put(MyOrderRepository());
  final Rx<ApiResponse<GetOrderResponse>> myOrderResponse =
      ApiResponse<GetOrderResponse>.initial().obs;

  @override
  void onInit() async {
    super.onInit();
    getPhysicalItems();
  }

  Future<void> getPhysicalItems() async {
    try {
      isItems(false);

      orderLoading(true);
      myOrderResponse.value = ApiResponse<GetOrderResponse>.loading();
      final itemsResult = await myOrderRepository.getOrders('DELIVERED');
      if (itemsResult.status == ApiStatus.SUCCESS) {
        myOrderResponse.value =
            ApiResponse<GetOrderResponse>.completed(itemsResult.response);
        // log('thisi sthe lengtho f hte filtered items ${myOrderResponse.value.response!.data.length}');

        if (myOrderResponse.value.response!.data.length > 0) {
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
