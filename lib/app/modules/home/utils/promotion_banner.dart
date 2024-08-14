import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/modules/cart/cart_page.dart';
import 'package:organicbazzar/app/modules/home/utils/cart_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PromotionalBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: screenHeight * 0.55,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('assets/promotion.png'), // Add your image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Red Container with GestureDetector
          Positioned(
            top: 5.h,
            left: 5.w,
            child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                //drawer icns
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 21.0.sp,
                )),
          ),
          Positioned(
            top: 5.h,
            right: 10.w,
            child: GestureDetector(
              onTap: () {
                Get.to(() => CartPage(),
                    transition: Transition.downToUp,
                    duration: Duration(milliseconds: 300));
              },
              child: ShoppingCartIcon(),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Fruits & Vegetables',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Produced by local & it\'s safe to eat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Shop Now',
                  style: TextStyle(
                    color: Color(0xff93C22F),
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
