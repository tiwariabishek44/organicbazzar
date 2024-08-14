import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/forget_password/forget_password_controller.dart';
import 'package:organicbazzar/app/modules/forget_password/otp_verificaito.dart';
import 'package:organicbazzar/app/widget/custom_button.dart';
import 'package:organicbazzar/app/widget/text_form_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});
  final forgetPasswordController = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      //appbar with the ios back button
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Form(
            key: forgetPasswordController.forgetPasswordKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Forget password",
                  style: AppStyle.heading1(),
                ),
                SizedBox(
                  height: 5.h,
                ),
                TextFormFieldWidget(
                  textInputType: TextInputType.emailAddress,
                  hintText: "Email",
                  controller: forgetPasswordController.emailController1,
                  validatorFunction: (value) {
                    if (value.isEmpty) {
                      return "Email is required";
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                  actionKeyboard: TextInputAction.next,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                SizedBox(height: 2.h),
                Text(
                  "We'll send the verification code to this email if it matches an existing OrganicBazzar account",
                  style: AppStyle.text(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Obx(() => CustomButton(
                    buttonColor: AppColor.primaryColor,
                    textColor: Colors.white,
                    text: 'Send OTP',
                    onPressed: () {
                      // close the keyobard
                      FocusScope.of(context).unfocus();
                      forgetPasswordController.sendOtp(
                          context,
                          forgetPasswordController.emailController1.text
                              .trim());
                    },
                    isLoading: forgetPasswordController.sendOtpLoading.value))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
