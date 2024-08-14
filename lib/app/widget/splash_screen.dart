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
        await Future.wait([
          loginController.getUserData(),
          latestProductController.getLatestItems(),
          ourProductController.getRegularProducts(),
        ]);

        Get.offAll(() => HomePage());
      } else {
        // // User is not authenticated, navigate to LoginScreen
        Get.offAll(() =>
            OnboardingScreen()); // Assuming OnboardingScreen is the login screen
        // Get.offAll(() => Home());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0FFF6),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/leaf.png', // Update this path with your actual image asset path
                scale: 6.sp,
              ),
              Text('Organic Bazzar',
                  style: GoogleFonts.poppins(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  )),
              SizedBox(
                height: 2.h, // Adjust the space above the loading spinner
              ),
              SpinKitFadingCircle(
                color: AppColor.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
