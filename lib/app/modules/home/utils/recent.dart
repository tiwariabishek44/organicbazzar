import 'package:flutter/material.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/home/product_list.dart';
import 'package:organicbazzar/app/widget/product_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecentlyListed extends StatelessWidget {
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
                fontSize: 19.0.sp,
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
          padding: EdgeInsets.only(bottom: 3.0.h),
          child: Container(
            color: AppColor.backgroundColor,
            height: 236,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(isShadow: false, product: products[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
