import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/modules/cart/cart_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardShrimmer extends StatelessWidget {
  ProductCardShrimmer({
    super.key,
  });
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: Color.fromARGB(255, 238, 238, 238),
          highlightColor: Color.fromARGB(255, 255, 255, 255),
          child: Container(
            margin: EdgeInsets.only(right: 3.w),
            height: 16.h,
            width: 40.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ]
                // No shadow if isShadow is false
                ),
          )),
    );
  }
}
