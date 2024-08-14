import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/modules/order/order_controller.dart';
import 'package:organicbazzar/app/modules/order/order_page.dart';
import 'package:organicbazzar/app/modules/order/utils/no_order.dart';
import 'package:organicbazzar/app/modules/order/utils/order_tile.dart';
import 'package:organicbazzar/app/modules/order/utils/order_tile_shrimmer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllOrdersTab extends StatelessWidget {
  final myOrderController = Get.put(MyOrderController());
  @override
  Widget build(BuildContext context) {
    myOrderController.getOrders();
    return Obx(() {
      if (myOrderController.orderLoading.value) {
        return SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return OrderTileShrimmer();
          },
          childCount: 5, // Replace with actual order count
        ));
      } else {
        if (myOrderController.isItems.value) {
          final filteredOrders = myOrderController
              .myOrderResponse.value.response!.data
              .where((order) => order.status != 'DELIVERED')
              .toList();
          if (filteredOrders.isNotEmpty) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return OrderCard(
                  order: filteredOrders[index],
                );
              },
              childCount:
                  filteredOrders.length, // Replace with actual order count
            ));
          } else {
            return SliverToBoxAdapter(child: NoOrdersPage());
          }
        } else {
          return SliverToBoxAdapter(child: NoOrdersPage());
        }
      }
    });
  }
}
