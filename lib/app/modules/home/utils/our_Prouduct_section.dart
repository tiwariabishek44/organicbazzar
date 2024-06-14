import 'package:flutter/material.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/home/product_list.dart';
import 'package:organicbazzar/app/widget/product_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OurProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 3.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Products',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 19.sp,
              ),
            ),
            Text(
              'View all',
              style: AppStyle.text().copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.buttonColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.77,
              crossAxisSpacing: 0,
              mainAxisSpacing: 15,
            ),
            itemCount: products1.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products1[index]);
            },
          ),
        ),
      ],
    );
  }
}
