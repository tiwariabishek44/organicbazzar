import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TermsAndConditionsPage extends StatelessWidget {
  final VoidCallback onAccept;

  TermsAndConditionsPage({required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              size: 20.sp, color: AppColor.textColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Terms and Conditions",
          style: TextStyle(color: AppColor.textColor, fontSize: 18.sp),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("1. Acceptance of Terms"),
                  _buildParagraph(
                    "By accessing and using the Organic Bazzar app, you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use our app.",
                  ),
                  _buildSectionTitle("2. Use of the App"),
                  _buildParagraph(
                    "You agree to use the Organic Bazzar app only for lawful purposes and in a way that does not infringe the rights of, restrict or inhibit anyone else's use and enjoyment of the app.",
                  ),
                  _buildSectionTitle("3. Product Information"),
                  _buildParagraph(
                    "We strive to provide accurate product information, but we do not warrant that product descriptions or other content is accurate, complete, reliable, current, or error-free.",
                  ),
                  _buildSectionTitle("4. Pricing and Availability"),
                  _buildParagraph(
                    "All prices are subject to change without notice. We reserve the right to modify or discontinue any product without notice.",
                  ),
                  _buildSectionTitle("5. Privacy Policy"),
                  _buildParagraph(
                    "Your use of the Organic Bazzar app is also governed by our Privacy Policy. Please review our Privacy Policy, which also governs the app and informs users of our data collection practices.",
                  ),
                  // Add more sections as needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.textColor,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColor.textColor.withOpacity(0.8),
        ),
      ),
    );
  }
}
