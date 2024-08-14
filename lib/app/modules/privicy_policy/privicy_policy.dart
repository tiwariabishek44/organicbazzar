import 'package:flutter/material.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: ListView(
          children: [
            _buildHeader(),
            SizedBox(height: 2.h),
            _buildTableOfContents(),
            SizedBox(height: 2.h),
            _buildContentSections(),
          ],
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
          'Privacy Policy',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Your privacy is important to us. This privacy policy explains how we collect, use, and protect your information.',
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildTableOfContents() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Table of Contents',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            ..._buildTOCItems(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTOCItems() {
    List<String> sections = [
      'Introduction',
      'Data Collection',
      'Use of Data',
      'Data Sharing and Disclosure',
      'Data Security',
      'User Rights',
      'Cookies and Tracking Technologies',
      'Changes to the Privacy Policy',
      'Contact Information',
    ];

    return sections.map((section) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 0.5.h),
        child: Text(
          section,
          style: TextStyle(fontSize: 16.sp, color: Colors.blue),
        ),
      );
    }).toList();
  }

  Widget _buildContentSections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          title: 'Introduction',
          content: 'This is the introduction section of the privacy policy.',
        ),
        _buildSection(
          title: 'Data Collection',
          content: 'Details about the data we collect from users.',
        ),
        _buildSection(
          title: 'Use of Data',
          content: 'How we use the collected data.',
        ),
        _buildSection(
          title: 'Data Sharing and Disclosure',
          content: 'Information about how we share and disclose data.',
        ),
        _buildSection(
          title: 'Data Security',
          content: 'Measures we take to protect your data.',
        ),
        _buildSection(
          title: 'User Rights',
          content: 'Your rights regarding your data.',
        ),
        _buildSection(
          title: 'Cookies and Tracking Technologies',
          content: 'Our use of cookies and tracking technologies.',
        ),
        _buildSection(
          title: 'Changes to the Privacy Policy',
          content: 'How we will notify you of changes to the policy.',
        ),
        _buildSection(
          title: 'Contact Information',
          content: 'How you can contact us regarding the privacy policy.',
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.all(2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            content,
            style: TextStyle(fontSize: 16.sp),
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
            'Follow us on',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.facebook),
                onPressed: () {
                  // Facebook link
                },
              ),
              IconButton(
                icon: Icon(Icons.headset_mic_outlined),
                onPressed: () {
                  // Twitter link
                },
              ),
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  // LinkedIn link
                },
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            'Contact us at: support@example.com',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 1.h),
          Text(
            '© 2024 Your Company. All rights reserved.',
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
