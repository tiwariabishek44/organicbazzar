import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/model/get_order_response.dart';
import 'package:organicbazzar/app/modules/order_details/order_detials_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderCard extends StatelessWidget {
  final Orders order;

  const OrderCard({
    required this.order,
  });

  double _calculateTotalAmount() {
    double total = 0.0;
    for (var detail in order.orderDetails) {
      total += detail.product.price * detail.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final displayStatus =
        order.status == 'ORDERED' ? 'Processing' : 'Delivered';
    final totalAmount = _calculateTotalAmount();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Get.to(() => OrderDetailsPage(
                    order: order,
                  ));
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${order.id}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      _buildStatusIndicator(displayStatus),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.shopping_basket_outlined,
                          color: Colors.grey[600], size: 18.sp),
                      SizedBox(width: 8),
                      Text(
                        '${order.orderDetails.length} ${order.orderDetails.length == 1 ? 'item' : 'items'}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Spacer(),
                      Text(
                        '\Rs ${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String displayStatus) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: order.status != 'ORDERED'
            ? Colors.green.withOpacity(0.1)
            : AppColor.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: order.status != 'ORDERED'
                  ? Colors.green
                  : AppColor.primaryColor,
            ),
          ),
          SizedBox(width: 6),
          Text(
            displayStatus,
            style: TextStyle(
              color: order.status != 'ORDERED'
                  ? Colors.green
                  : AppColor.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
