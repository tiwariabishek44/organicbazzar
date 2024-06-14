import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/login/login_page.dart';
import 'package:organicbazzar/app/widget/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Image.asset(
                'assets/onboarding.jpg',
                height: 80.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 60.h, // Adjust as necessary to overlap the image slightly
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColor.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Welcome  to OrganicBazzar !",
                    style: AppStyle.heading1(),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "Your one-stop shop for Good Food and Greate Deals Discover Freshness, Taste the Difference",
                    style: AppStyle.onboardingText(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomButton(
                      buttonColor: AppColor.buttonColor,
                      textColor: AppColor.backgroundColor,
                      text: "Continue",
                      onPressed: () {
                        Get.to(() => LoginView(),
                            transition: Transition.cupertinoDialog,
                            duration: pageTransitionDuration);
                      },
                      isLoading: false)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
