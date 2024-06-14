import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/order/order_page.dart';
import 'package:organicbazzar/app/widget/log_out_cornfirmation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        // border radius in the top and bottm right part
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColor.backgroundColor),
            accountName: Text('John Doe',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            accountEmail: Text('john.doe@example.com',
                style: TextStyle(
                  color: Colors.black,
                )),
            currentAccountPicture: CircleAvatar(
              child: Text(
                'JD',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
              ),
              backgroundColor: AppColor.buttonColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Account'),
            onTap: () {
              // Navigate to Account
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Orders'),
            onTap: () {
              Get.to(() => OrderPage(),
                  transition: Transition.cupertinoDialog,
                  duration: pageTransitionDuration);
              // Navigate to Orders
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact Us'),
            onTap: () {
              // Navigate to Contact Us
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            onTap: () {
              // Navigate to Privacy Policy
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Get.back();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LogoutConfirmationDialog(
                    heading: "Logout",
                    subheading: "Are you sure you want to logout?",
                    isbutton: true,
                    firstbutton: "Yes",
                    secondbutton: "No",
                    onConfirm: () {
                      // Handle the logout logic here
                      Get.back();
                      print("User logged out");
                    },
                  );
                },
              );
              // Handle logout
            },
          ),
        ],
      ),
    );
  }
}
