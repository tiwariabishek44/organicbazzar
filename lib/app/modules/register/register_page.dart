import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/register/register_controller.dart';
import 'package:organicbazzar/app/widget/custom_button.dart';
import 'package:organicbazzar/app/widget/loading_widget.dart';
import 'package:organicbazzar/app/widget/text_form_field.dart';
import 'package:organicbazzar/app/widget/welcome_heading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterView extends StatelessWidget {
  RegisterView({
    super.key,
  });

  final registercontroller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: AppColor.backgroundColor,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: AppColor.backgroundColor,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_sharp),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                WelcomeHeading(
                    mainHeading: "Create an Account", subHeading: ''),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: AppPadding.screenHorizontalPadding,
                  child: Form(
                    key: registercontroller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormFieldWidget(
                          prefixIcon: const Icon(Icons.person),
                          textInputType: TextInputType.text,
                          hintText: 'Name',
                          controller: registercontroller.nameController,
                          validatorFunction: (value) {
                            if (value.isEmpty) {
                              return '  Name Can\'t be empty';
                            }
                            return null;
                          },
                          actionKeyboard: TextInputAction.next,
                          onSubmitField: () {},
                        ),
                        SizedBox(height: 2.h),
                        TextFormFieldWidget(
                          prefixIcon: const Icon(Icons.email),
                          textInputType: TextInputType.emailAddress,
                          hintText: 'Email',
                          controller: registercontroller.emailController,
                          validatorFunction: (value) {
                            if (value.isEmpty) {
                              return 'Email Name Can\'t be empty';
                            }

                            return null;
                          },
                          actionKeyboard: TextInputAction.next,
                          onSubmitField: () {},
                        ),
                        SizedBox(height: 2.h),
                        TextFormFieldWidget(
                          prefixIcon: const Icon(Icons.maps_home_work_sharp),
                          textInputType: TextInputType.emailAddress,
                          hintText: 'Address',
                          controller: registercontroller.addressController,
                          validatorFunction: (value) {
                            if (value.isEmpty) {
                              return 'Address Can\'t be empty';
                            }

                            return null;
                          },
                          actionKeyboard: TextInputAction.next,
                          onSubmitField: () {},
                        ),
                        SizedBox(height: 2.h),
                        TextFormFieldWidget(
                          prefixIcon: const Icon(Icons.phone),
                          textInputType: TextInputType.number,
                          hintText: 'Mobile Number',
                          controller: registercontroller.mobileNumberController,
                          validatorFunction: (value) {
                            if (value.isEmpty) {
                              return 'Mobile number Can\'t be empty';
                            }
                            if (value.length < 10) {
                              return 'Mobile number must contain  10 character';
                            }
                            return null;
                          },
                          actionKeyboard: TextInputAction.next,
                          onSubmitField: () {},
                        ),
                        SizedBox(height: 2.h),
                        Obx(
                          () => TextFormFieldWidget(
                            prefixIcon: const Icon(Icons.lock),
                            textInputType: TextInputType.visiblePassword,
                            hintText: 'Password',
                            controller: registercontroller.passwordController,
                            obscureText:
                                !registercontroller.ispasswordvisible.value,
                            suffixIcon: IconButton(
                              onPressed: () {
                                registercontroller.ispasswordvisible.value =
                                    !registercontroller.ispasswordvisible.value;
                              },
                              icon: Icon(
                                registercontroller.ispasswordvisible.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                            validatorFunction: (value) {
                              if (value.isEmpty) {
                                return 'Enter the password';
                              }
                              if (value.length < 8) {
                                return 'Password must contain atleast 8 character';
                              }
                              return null;
                            },
                            actionKeyboard: TextInputAction.next,
                            onSubmitField: () {},
                          ),
                        ),
                        SizedBox(height: 2.h),
                        SizedBox(
                          height: 2.h,
                        ),
                        Obx(
                          () => Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                                child: Checkbox(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    return Colors
                                        .white; // Change this to the default color you want.
                                  }),
                                  checkColor: AppColor.backgroundColor,
                                  focusColor: AppColor.buttonColor,
                                  value: registercontroller
                                      .termsandcondition.value,
                                  onChanged: (value) {
                                    registercontroller.termsandcondition.value =
                                        !registercontroller
                                            .termsandcondition.value;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 70.w,
                                child: RichText(
                                  maxLines: 4,
                                  text: TextSpan(
                                    text: "I have read and agreed to the ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Terms and Conditions",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          decoration: TextDecoration.underline,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomButton(
                          buttonColor: AppColor.buttonColor,
                          textColor: AppColor.backgroundColor,
                          text: "Register",
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                          },
                          isLoading: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ))),
        Obx(() => registercontroller.isloading.value
            ? Positioned(
                left: 40.w, top: 50.h, child: Center(child: LoadingWidget()))
            : SizedBox.shrink())
      ],
    );
  }
}
