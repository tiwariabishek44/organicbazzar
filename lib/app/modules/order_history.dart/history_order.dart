import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/modules/order/order_controller.dart';
import 'package:organicbazzar/app/modules/order/order_page.dart';
import 'package:organicbazzar/app/modules/order/utils/no_order.dart';
import 'package:organicbazzar/app/modules/order/utils/order_tile.dart';
import 'package:organicbazzar/app/modules/order/utils/order_tile_shrimmer.dart';
import 'package:organicbazzar/app/modules/order_history.dart/order_history_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HistoryOrderTAb extends StatelessWidget {
  final orderHIstoryContorller = Get.put(OrderHistoryController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (orderHIstoryContorller.orderLoading.value) {
        return SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return OrderTileShrimmer();
          },
          childCount: 5, // Replace with actual order count
        ));
      } else {
        if (orderHIstoryContorller.isItems.value) {
          final filteredOrders = orderHIstoryContorller
              .myOrderResponse.value.response!.data
              .where((order) => order.status == 'DELIVERED')
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
            return SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    20, // Adjust this value as needed
              ),
            );
          }
        } else {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  200, // Adjust this value as needed
              child: NoOrdersPage(),
            ),
          );
        }
      }
    });
  }
}
