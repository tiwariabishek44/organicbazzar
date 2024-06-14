import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/widget/custom_button.dart';
import 'package:organicbazzar/app/widget/onboarding_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Add this line to navigate to the next page after 1 second
    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(
        () => OnboardingScreen(),
        transition: Transition.cupertinoDialog,
        duration: pageTransitionDuration,
      );
    });

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/leaf.png', // Update this path with your actual image asset path
                width: 20.w, // Adjust the width as needed
                color: AppColor.buttonColor,
              ),
              Text(
                'OrganicBazzar',
                style: GoogleFonts.lato(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.buttonColor,
                ),
              ),
              SizedBox(
                height: 10.h, // Adjust the space above the loading spinner
              ),
              SpinKitFadingCircle(
                color: AppColor.buttonColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
