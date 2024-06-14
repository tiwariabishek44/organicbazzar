import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppPadding {
  static EdgeInsetsGeometry get screenHorizontalPadding {
    return EdgeInsets.symmetric(horizontal: 2.w);
  }
}

const Duration pageTransitionDuration = Duration(milliseconds: 100);

class AppStyle {
  static TextStyle heading1() {
    return GoogleFonts.roboto(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      // Add any additional styling properties here
    );
  }

  static TextStyle heading2() {
    return GoogleFonts.roboto(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      // Add any additional styling properties here
    );
  }

  static TextStyle onboardingText() {
    return GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      color: const Color.fromARGB(255, 157, 156, 156),
      fontSize: 18.sp,
      // Add any additional styling properties here
    );
  }

  static TextStyle text() {
    return GoogleFonts.roboto(
      fontWeight: FontWeight.w700,
      fontSize: 17.sp,
      // Add any additional styling properties here
    );
  }

  static TextStyle text2() {
    return GoogleFonts.roboto(
      fontSize: 14.sp,
      // Add any additional styling properties here
    );
  }

  static headingStyle() {}
}
