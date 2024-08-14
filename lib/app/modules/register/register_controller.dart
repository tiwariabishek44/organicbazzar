import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/model/otp_response.dart';
import 'package:organicbazzar/app/model/register_response_model.dart';
import 'package:organicbazzar/app/modules/login/login_page.dart';
import 'package:organicbazzar/app/modules/register/otp_verification.dart';
import 'package:organicbazzar/app/repository/otp_verification_repository.dart';
import 'package:organicbazzar/app/repository/register_repository.dart';
import 'package:organicbazzar/app/service/api_client.dart';
import 'package:organicbazzar/app/widget/custom_snackbar.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final mobileNumberController = TextEditingController();
  var otpPin = ''.obs;
  var ispasswordvisible = false.obs;
  var termsandcondition = false.obs;

  final isregisterLoading = false.obs;
  var isOtpVerify = false.obs;
  void registerUser(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (termsandcondition.value) {
        register(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please agree to the terms and conditions!'),
          ),
        );
      }
    }
  }

  final UserRegisterRepository registerRepository = UserRegisterRepository();
  final Rx<ApiResponse<RegisterResponseModel>> registerResponse =
      ApiResponse<RegisterResponseModel>.initial().obs;

  Future<void> register(BuildContext context) async {
    try {
      isregisterLoading(true);
      registerResponse.value = ApiResponse<RegisterResponseModel>.loading();
      final user = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": mobileNumberController.text.trim(),
        "address": "ssiisi",
        "password": passwordController.text.trim()
      };

      final registerResult = await registerRepository.registerUser(user);
      // log('-------------------------user data-------------');

      if (registerResult.status == ApiStatus.SUCCESS) {
        registerResponse.value = ApiResponse<RegisterResponseModel>.completed(
            registerResult.response);

        log('-----s' + registerResult.status.toString());
        Get.to(
            () => OtpVerification(
                  token: registerResponse.value.response!.data!.toString(),
                ),
            transition: Transition.cupertinoDialog);
        isregisterLoading(false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.primaryColor,
            content: Text(registerResult.message.toString()),
          ),
        );
        isregisterLoading(false);
      }
    } catch (e) {
      isregisterLoading(false);
    }
  }

//----------------VERIFY OTP -----------

  void verify(BuildContext context, String token) {
    // log(otpPin.value + " this is the otp and token      ----" + token);
    otpVerify(context, token);
  }

  final OtpVerifyRepository verifyRepository = OtpVerifyRepository();
  final Rx<ApiResponse<OtpResponse>> otpResponse =
      ApiResponse<OtpResponse>.initial().obs;

  Future<void> otpVerify(BuildContext context, String token) async {
    try {
      isOtpVerify(true);
      otpResponse.value = ApiResponse<OtpResponse>.loading();
      final user = {"token": token, "otp": otpPin.value.toString()};

      final verifyReult = await verifyRepository.verifyOtp(user);
      log(verifyReult.status.toString());
      // log('-------------------------user data-------------');

      if (verifyReult.status == ApiStatus.SUCCESS) {
        otpResponse.value =
            ApiResponse<OtpResponse>.completed(verifyReult.response);
        // log('-----s' + registerResult.status.toString());
        // Navigate to home page or perform necessary actions upon successful login
        Get.offAll(() => LoginView());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.primaryColor,
            content: Text('Otp Verified Successfully'),
          ),
        );
        isOtpVerify(false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.primaryColor,
            content: Text(verifyReult.message.toString()),
          ),
        );
        isOtpVerify(false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.primaryColor,
          content: Text('The error is $e'),
        ),
      );
      isOtpVerify(false);

      log("thi is error $e");
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    mobileNumberController.dispose();
    super.onClose();
  }
}
