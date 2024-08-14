import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/modules/our_product/our_product_controller.dart';
import 'package:organicbazzar/app/modules/our_product/utils/product_card_shrimmer.dart';
import 'package:organicbazzar/app/widget/product_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RelativeProduct extends StatelessWidget {
  final ourProductController = Get.put(OurProductController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 3.0.h),
          child: Obx(() {
            if (ourProductController.productLoading.value) {
              return Container(
                color: AppColor.backgroundColor,
                height: 236,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ProductCardShrimmer();
                  },
                ),
              );
            } else {
              if (ourProductController.isItems.value) {
                return Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      height: 236,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ourProductController
                              .physicalItemresponse.value.response!.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                                product: ourProductController
                                    .physicalItemresponse
                                    .value
                                    .response![index]);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            }
          }),
        ),
      ],
    );
  }
}
