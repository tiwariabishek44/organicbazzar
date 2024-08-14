import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/home/utils/promotion_banner.dart';
import 'package:organicbazzar/app/modules/latest_product/latest_product.dart';
import 'package:organicbazzar/app/modules/latest_product/latest_proudct_controller.dart';
import 'package:organicbazzar/app/modules/login/login_controller.dart';
import 'package:organicbazzar/app/modules/our_product/our_product.dart';
import 'package:organicbazzar/app/modules/our_product/our_product_controller.dart';
import 'package:organicbazzar/app/widget/custom_drawer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatelessWidget {
  final ourProductController = Get.put(OurProductController());
  final latestProductController = Get.put(LatestProductController());
  final logincontorller = Get.put(LoginController());

  Future<void> _refreshContent() async {
    await Future.wait([
      logincontorller.getUserData(),
      latestProductController.getLatestItems(),
      ourProductController.getRegularProducts(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () async {
          print('Current Route: ${Get.currentRoute}');
          if (Get.currentRoute == '/') {
            return await Get.dialog<bool>(
                  AlertDialog(
                    title: Text('Exit App'),
                    content: Text('Are you sure you want to exit?'),
                    actions: [
                      TextButton(
                        child: Text('No'),
                        onPressed: () => Get.back(result: false),
                      ),
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () => Get.back(result: true),
                      ),
                    ],
                  ),
                ) ??
                false;
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: CustomDrawer(),
          body: RefreshIndicator(
            onRefresh: _refreshContent,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PromotionalBanner(),
                  Padding(
                    padding: AppPadding.screenHorizontalPadding,
                    child: Column(
                      children: [
                        SizedBox(height: 4.h),
                        LatestProduct(),
                        OurProducts(),
                        SizedBox(
                          height: 5.h,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
