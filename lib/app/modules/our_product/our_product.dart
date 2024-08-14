import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/modules/our_product/our_product_controller.dart';
import 'package:organicbazzar/app/modules/our_product/utils/product_card_shrimmer.dart';
import 'package:organicbazzar/app/widget/product_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OurProducts extends StatelessWidget {
  final ourpProductController = Get.put(OurProductController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // divider
        Divider(
          color: const Color.fromARGB(255, 197, 195, 195),
          thickness: 1,
        ),

        SizedBox(
          height: 1.h,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "Our Products",
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 24, 24, 24)),
          ),
        ),

        Obx(() {
          if (ourpProductController.productLoading.value) {
            return Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.89,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return ProductCardShrimmer();
                },
              ),
            );
          } else {
            if (ourpProductController.isItems.value) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.73,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: ourpProductController
                    .physicalItemresponse.value.response!.length,
                itemBuilder: (context, index) {
                  // to print the id
                  return ProductCard(
                      product: ourpProductController
                          .physicalItemresponse.value.response![index]);
                },
              );
            } else {
              return Center(
                child: Text('No Items Found'),
              );
            }
          }
        }),
      ],
    );
  }
}
