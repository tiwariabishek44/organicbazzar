import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/about%20us/about_us.dart';
import 'package:organicbazzar/app/modules/contact_us/contact_us_page.dart';
import 'package:organicbazzar/app/modules/login/login_controller.dart';
import 'package:organicbazzar/app/modules/order/order_page.dart';
import 'package:organicbazzar/app/modules/privicy_policy/privicy_policy.dart';
import 'package:organicbazzar/app/modules/user_account/account.dart';
import 'package:organicbazzar/app/widget/log_out_cornfirmation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);

  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Expanded(child: _buildNavigation()),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Obx(() {
      final userName =
          _loginController.userDataResponse.value.response?.data.name ??
              'Guest';
      final userInitials =
          userName.split(' ').take(2).map((e) => e[0]).join('').toUpperCase();

      return Container(
        padding: EdgeInsets.all(24),
        color: AppColor.primaryColor.withOpacity(0.1),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColor.primaryColor,
              child: Text(
                userInitials,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _loginController
                            .userDataResponse.value.response?.data.phone ??
                        'Sign in to your account',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildNavigation() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16),
      children: [
        _buildNavItem(
          'My Account',
          Icons.person_outline,
          () => Get.to(() => AccountInfo(),
              transition: Transition.cupertinoDialog),
        ),
        _buildNavItem(
          'My Orders',
          Icons.shopping_bag_outlined,
          () =>
              Get.to(() => OrderPage(), transition: Transition.cupertinoDialog),
        ),
        // _buildNavItem(
        //   'Contact Us',
        //   Icons.contact_support_outlined,
        //   () =>
        //       Get.to(() => ContactUsPage(), transition: Transition.rightToLeft),
        // ),
        _buildNavItem(
          'Privacy Policy',
          Icons.privacy_tip_outlined,
          () => Get.to(() => PrivacyPolicyPage(),
              transition: Transition.cupertinoDialog),
        ),
        _buildNavItem(
          'About Us',
          Icons.info_outline,
          () => Get.to(() => AboutUsPage(),
              transition: Transition.cupertinoDialog),
        ),
      ],
    );
  }

  Widget _buildNavItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColor.primaryColor, size: 22.sp),
      title: Text(title, style: TextStyle(fontSize: 16.sp)),
      onTap: () {
        Get.back(); // Close the drawer
        onTap();
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Divider(color: Colors.grey[300]),
          SizedBox(height: 16),
          InkWell(
            onTap: () => _showLogoutDialog(context),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.exit_to_app,
                      color: AppColor.primaryColor, size: 22.sp),
                  SizedBox(width: 16),
                  Text(
                    'Log Out',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutPopup(
          onConfirmLogout: () {
            _loginController.logout();
            Navigator.of(context).pop(); // Close the dialog
            Get.back(); // Close the drawer
          },
        );
      },
    );
  }
}

class LogoutPopup extends StatelessWidget {
  final VoidCallback onConfirmLogout;

  const LogoutPopup({Key? key, required this.onConfirmLogout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Log Out'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: onConfirmLogout,
        ),
      ],
    );
  }
}
