import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/modules/cart/cart_controller.dart';
import 'package:organicbazzar/app/modules/cart/cart_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShoppingCartIcon extends StatelessWidget {
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 21.0.sp,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 25.0.sp,
          ),
          Obx(() {
            if (cartController.cartItems.length > 0) {
              return Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    '${cartController.cartItems.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              return Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    '${cartController.cartItems.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
              ; // Return an empty container when no items are in the cart
            }
          }),
        ],
      ),
    );
  }
}
