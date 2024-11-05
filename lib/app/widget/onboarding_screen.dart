import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/login/login_controller.dart';
import 'package:organicbazzar/app/modules/login/login_page.dart';
import 'package:organicbazzar/app/widget/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    _checkNotificationPermission();
  }

  void _checkNotificationPermission() async {
    final status = await Permission.notification.status;
    // if (status.isDenied) {
    //   _showNotificationPermissionDialog();
    // }
  }

  // void _showNotificationPermissionDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Enable Notifications"),
  //         content: Text(
  //             "Would you like to enable notifications for a better experience?"),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text("No Thanks"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text("Allow"),
  //             onPressed: () async {
  //               Navigator.of(context).pop();
  //               openAppSettings();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _proceedToNextPage() {
    loginController.registerDevice();
    Get.to(() => LoginView(),
        transition: Transition.cupertinoDialog,
        duration: pageTransitionDuration);
  }

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
            top: 60.h,
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
                    "Welcome to OrganicBazzar!",
                    style: AppStyle.heading1(),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Your one-stop shop for Good Food and Great Deals. Discover Freshness, Taste the Difference",
                    style: AppStyle.onboardingText(),
                  ),
                  SizedBox(height: 2.h),
                  CustomButton(
                    buttonColor: AppColor.primaryColor,
                    textColor: AppColor.backgroundColor,
                    text: "Continue",
                    onPressed: _proceedToNextPage,
                    isLoading: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
