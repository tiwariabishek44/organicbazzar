import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/modules/login/login_controller.dart';
import 'package:organicbazzar/app/modules/user_account/update_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({Key? key}) : super(key: key);

  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              size: 20.sp, color: AppColor.textColor),
          onPressed: () => Get.back(),
        ),
        title: Text("Account",
            style: TextStyle(color: AppColor.textColor, fontSize: 18.sp)),
      ),
      body: Obx(() {
        if (!_loginController.userdataFetched.value) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 3.h),
              _buildInfoSection(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      color: AppColor.primaryColor.withOpacity(0.1),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.primaryColor,
            child: Text(
              _loginController.userDataResponse.value.response!.data.name
                  .substring(0, 2)
                  .toUpperCase(),
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _loginController.userDataResponse.value.response!.data.name,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  _loginController.userDataResponse.value.response!.data.email,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personal Information",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.textColor),
          ),
          SizedBox(height: 2.h),
          _buildInfoTile(
            icon: Icons.person_outline,
            title: "Name",
            value: _loginController.userDataResponse.value.response!.data.name,
            onTap: () {},
            isVerified: true,
          ),
          _buildInfoTile(
            icon: Icons.location_on_outlined,
            title: "Address",
            value:
                _loginController.userDataResponse.value.response!.data.address,
            onTap: () => Get.to(() => UpdatePage(isphoneChange: false)),
          ),
          _buildInfoTile(
            icon: Icons.phone_outlined,
            title: "Phone",
            value: _loginController.userDataResponse.value.response!.data.phone,
            onTap: () => Get.to(() => UpdatePage(isphoneChange: true)),
          ),
          _buildInfoTile(
            icon: Icons.email_outlined,
            title: "Email",
            value: _loginController.userDataResponse.value.response!.data.email,
            onTap: () {},
            isVerified: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
    bool isVerified = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Icon(icon, size: 24.sp, color: AppColor.primaryColor),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontSize: 14.sp, color: Colors.grey[600])),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          value,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      if (isVerified)
                        Icon(Icons.verified, size: 18.sp, color: Colors.green)
                      else
                        Icon(Icons.chevron_right,
                            size: 20.sp, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
