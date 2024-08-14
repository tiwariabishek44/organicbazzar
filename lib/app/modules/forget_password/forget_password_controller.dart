import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/forget_password_response.dart';
import 'package:organicbazzar/app/modules/forget_password/otp_verificaito.dart';
import 'package:organicbazzar/app/modules/login/login_page.dart';
import 'package:organicbazzar/app/repository/forget_password_repository.dart';
import 'package:organicbazzar/app/service/api_client.dart';
import 'package:organicbazzar/app/widget/custom_snackbar.dart';
// import http
import 'package:http/http.dart' as http;

class ForgetPasswordController extends GetxController {
  final storage = GetStorage();

  final forgetPasswordKey = GlobalKey<FormState>();
  final newPasswordKey = GlobalKey<FormState>();

  final emailController1 = TextEditingController();
  final newPasswordController = TextEditingController();
  var sendOtpLoading = false.obs;
  var passwordChangeLoading = false.obs;
  var otpError = true.obs;
  var otpPin = ''.obs;

  void sendOtp(BuildContext context, String email) {
    if (forgetPasswordKey.currentState!.validate()) {
      firstStep(email);
    }
  }

  void changePassword(BuildContext context, String email) {
    if (newPasswordKey.currentState!.validate()) {
      secondStep(email);
    }
  }

  final ForgetPasswordRepository forgetPasswordRepository =
      ForgetPasswordRepository();

//----------------------TO GET THE OTP FOR PASSWORD CHANGE-----------
  final Rx<ApiResponse<ForgetPasswordResponse>> firstStepresponse =
      ApiResponse<ForgetPasswordResponse>.initial().obs;

  Future<void> firstStep(String email) async {
    try {
      sendOtpLoading(true);
      firstStepresponse.value = ApiResponse<ForgetPasswordResponse>.loading();
      final user = {
        "email": emailController1.text.trim(),
      };
      final firstStepResult = await forgetPasswordRepository.firstStep(user);
      // log(registerResult.status.toString());

      if (firstStepResult.status == ApiStatus.SUCCESS) {
        firstStepresponse.value = ApiResponse<ForgetPasswordResponse>.completed(
            firstStepResult.response);
        // save the token locally
        otpPin.value = firstStepResult.response!.data;
        log("this is the otp ${otpPin.value}");
        // local storage of otppin
        storage.write("token", otpPin.value);
        Get.off(
          () => NewPasswordPage(
            email: email,
          ),
          transition: Transition.rightToLeft,
        );

        sendOtpLoading(false);
      } else {
        sendOtpLoading.value = false;
        CustomSnackBar.showFailure(" ${firstStepResult.message}");
      }
    } catch (e) {
      sendOtpLoading(false);
      log("Error: $e");
    }
  }

//--------------------TO CHANGE THE USER ACOUNT PASSWORD ---------

  final Rx<ApiResponse<ForgetPasswordResponse>> secondStepResponse =
      ApiResponse<ForgetPasswordResponse>.initial().obs;

  Future<void> secondStep(String email) async {
    try {
      passwordChangeLoading(true);

      final body = {
        "token": storage.read("token"),
        "newPassword": newPasswordController.text.trim(),
        "otp": otpPin.value.toString()
      };

      final response = await http.post(
        Uri.parse(ApiEndpoints.forgetpassword2),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        CustomSnackBar.showSuccess("Password Change Successfully");
        Get.offAll(() => LoginView());
      } else {
        CustomSnackBar.showFailure("Error: ${response.body}");
      }

      passwordChangeLoading(false);
    } catch (e) {
      passwordChangeLoading(false);
      CustomSnackBar.showFailure("Error: $e");
    }
  }

//-------------VALIDATOR-----------------
}
