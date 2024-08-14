import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/forget_password/forget_password_controller.dart';
import 'package:organicbazzar/app/widget/custom_button.dart';
import 'package:organicbazzar/app/widget/text_form_field.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewPasswordPage extends StatelessWidget {
  final String email;

  NewPasswordPage({Key? key, required this.email}) : super(key: key);
  final forgetpasswordController = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
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
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Form(
            key: forgetpasswordController.newPasswordKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Enter the 4-digit code",
                  style: AppStyle.heading1(),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          " Check ",
                          style: AppStyle.heading2(),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Text(
                      "for verification code",
                      style: AppStyle.heading2(),
                    ),
                  ],
                ),

                SizedBox(
                  height: 3.h,
                ),
                Center(
                  child: Pinput(
                    length: 4,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the 4-digit code';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter digits only';
                      }
                      return null;
                    },
                    onCompleted: (pin) {
                      forgetpasswordController.otpPin.value = pin;
                      log(" Otp pin ${pin}");
                    },
                    onChanged: (String? value) {
                      if (value!.isEmpty || value.length < 4) {
                        forgetpasswordController.otpError.value = true;
                      } else {
                        forgetpasswordController.otpError.value = false;
                      }
                    },
                  ),
                ),
                SizedBox(height: 1.h), // Adjust as needed
                TextButton(
                  onPressed: () {
                    // Add logic to resend the verification code
                    // Here, you can call a function to resend the code
                    forgetpasswordController.sendOtp(context, email);
                  },
                  child: Text(
                    'Resend code',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 4.h),

                TextFormFieldWidget(
                  prefixIcon: const Icon(Icons.lock),
                  textInputType: TextInputType.text,
                  hintText: 'Password',
                  controller: forgetpasswordController.newPasswordController,
                  obscureText: false,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility_off_outlined,
                    ),
                  ),
                  validatorFunction: (value) {
                    if (value.isEmpty) {
                      return 'Enter the password';
                    }
                    return null;
                  },
                  actionKeyboard: TextInputAction.done,
                  onSubmitField: () {},
                ),
                SizedBox(height: 2.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "If you don't see a code in your inbox, check your spam folder. If it's not there, the email address may not be confirmed, or it may not match an existing Benchmark account.",
                    style: AppStyle.text2(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
                SizedBox(height: 2.h),
                Obx(() => CustomButton(
                      buttonColor: AppColor.primaryColor,
                      text: 'Confirm',
                      onPressed: () {
// close the keyboard
                        FocusScope.of(context).unfocus();

                        forgetpasswordController.otpError.value
                            ? log(" Enter the 4 digit otp")
                            : forgetpasswordController.changePassword(
                                context, email);
                      },
                      isLoading:
                          forgetpasswordController.passwordChangeLoading.value,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
