import 'package:flutter/material.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WelcomeHeading extends StatelessWidget {
  final String mainHeading;
  final String subHeading;

  const WelcomeHeading({
    super.key,
    required this.mainHeading,
    required this.subHeading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${mainHeading}!",
            style: AppStyle.heading1(),
          ),
          Text(
            subHeading,
            style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 0, 0, 0)),
          ),
        ],
      ),
    );
  }
}
