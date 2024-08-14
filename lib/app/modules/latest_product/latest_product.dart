import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/latest_product/latest_proudct_controller.dart';
import 'package:organicbazzar/app/modules/our_product/utils/product_card_shrimmer.dart';
import 'package:organicbazzar/app/widget/product_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LatestProduct extends StatelessWidget {
  final latestProductController = Get.put(LatestProductController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 3.0.h),
          child: Obx(() {
            if (latestProductController.productLoading.value) {
              return Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.89,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return ProductCardShrimmer();
                  },
                ),
              );
            } else {
              if (latestProductController.isItems.value) {
                return Column(
                  children: [
                    // make a row having the divider ,text and divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: const Color.fromARGB(255, 197, 195, 195),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                          child: Text(
                            "Latest Products",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 65, 63, 63)),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: const Color.fromARGB(255, 197, 195, 195),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    // Text(
                    //   "Latest Products",
                    //   style: TextStyle(
                    //       fontSize: 20.sp, fontWeight: FontWeight.w700),
                    // ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.73,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: latestProductController
                          .latestItemResponse.value.response!.length,
                      itemBuilder: (context, index) {
                        // to print the id
                        return ProductCard(
                            product: latestProductController
                                .latestItemResponse.value.response![index]);
                      },
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            }
          }),
        ),
      ],
    );
  }
}
