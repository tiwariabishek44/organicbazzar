import 'package:flutter/material.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text('About Us'),
        // make the back iphone buton
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 2.h),
              _buildMission(),
              SizedBox(height: 2.h),
              _buildStory(),
              SizedBox(height: 2.h),
              _buildTeam(),
              SizedBox(height: 2.h),
              _buildLocation(),
              SizedBox(height: 2.h),
              _buildValues(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildFooter(),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to Organic Bazzar',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Your gateway to fresh, organic produce straight from local farmers.',
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildMission() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'To connect conscious consumers with local organic farmers, promoting healthier living and sustainable agriculture in Nepal.',
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Story',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Organic Bazzar was born from a passion for healthy living and supporting local communities. We started in Kathmandu, Tarkeshor, with a vision to make organic produce accessible to everyone while ensuring fair compensation for our hardworking farmers.',
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildTeam() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Team',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'We are a diverse group of individuals united by our commitment to organic farming and community development. Our team includes agricultural experts, tech enthusiasts, and customer service professionals.',
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Where to Find Us',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'We are proudly based in Kathmandu, Tarkeshor. Our operations span across the Kathmandu Valley, connecting local farmers with urban consumers.',
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildValues() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Values',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(height: 1.h),
            _buildValueItem(
                'Sustainability', 'We prioritize eco-friendly practices.'),
            _buildValueItem(
                'Quality', 'We ensure only the best organic produce.'),
            _buildValueItem(
                'Community', 'We support local farmers and economies.'),
            _buildValueItem(
                'Transparency', 'We believe in clear, honest operations.'),
          ],
        ),
      ),
    );
  }

  Widget _buildValueItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: AppColor.primaryColor),
          SizedBox(width: 1.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(2.h),
      color: Colors.grey[200],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Connect with Us',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.facebook, color: AppColor.primaryColor),
                onPressed: () {
                  // Facebook link
                },
              ),
              IconButton(
                icon: Icon(Icons.insights, color: AppColor.primaryColor),
                onPressed: () {
                  // Instagram link
                },
              ),
              IconButton(
                icon: Icon(Icons.email, color: AppColor.primaryColor),
                onPressed: () {
                  // Email link
                },
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            'Contact us at: support@organicbazzar.com',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 1.h),
          Text(
            '© 2024 Organic Bazzar. All rights reserved.',
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
