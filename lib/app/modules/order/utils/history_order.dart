import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/modules/order/utils/order_tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HistoryOrderTAb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return OrderTile(
          status: 'Delivered',
          orderDate: '03 Nov 2023',
          shippingDate: '08 Nov 2023',
          orderNumber: 'CWT0152',
        );
      },
    );
  }
}
