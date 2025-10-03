import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/modules/farming/farmer_homepage.dart';
import 'package:organicbazzar/app/modules/home/home_page.dart';
import 'package:organicbazzar/app/modules/latest_product/latest_proudct_controller.dart';
import 'package:organicbazzar/app/modules/login/login_controller.dart';
import 'package:organicbazzar/app/modules/our_product/our_product_controller.dart';
import 'package:organicbazzar/app/widget/onboarding_screen.dart';
import 'package:organicbazzar/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = GetStorage();
  final loginController = Get.put(LoginController());
  final latestProductController = Get.put(LatestProductController());
  final ourProductController = Get.put(OurProductController());

  @override
  void initState() {
    super.initState();
    navigateBasedOnAuthState();
  }

  void navigateBasedOnAuthState() {
    Timer(const Duration(seconds: 2), () async {
      if (loginController.isLogedIn()) {
        try {
          await Future.wait([
            loginController.getUserData(),
            latestProductController.getLatestItems(),
            ourProductController.getRegularProducts(),
          ]);
          Get.offAll(() => HomePage());
        } catch (e) {
          print('Error loading initial data: $e');
          // You might want to show a snackbar or dialog here for error handling
          Get.snackbar(
            'Error',
            'Failed to load initial data. Please check your connection.',
            backgroundColor: Colors.red[100],
            colorText: Colors.red[900],
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        Get.offAll(() => OnboardingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0FFF6),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/leaf.png',
                  scale: 6.sp,
                ),
                SizedBox(height: 2.h),
                Text(
                  'OrganicBazzar',
                  style: GoogleFonts.poppins(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                Text(
                  'Fresh & Organic',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 3.h),
                SpinKitFadingCircle(
                  color: AppColor.primaryColor,
                  size: 30.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
