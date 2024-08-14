import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NoOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/download.jpg', // Make sure to add this image to your assets
            width: 80.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 4.h),
          // Text(
          //   'Your Cart is Empty',
          //   style: TextStyle(
          //     fontSize: 24.sp,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.green[800],
          //   ),
          // ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              'You haven\'t placed any orders yet. Start exploring our organic products and make your first purchase!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // Navigate to product catalog or home page
            },
            child: Text(
              'Explore Products',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
