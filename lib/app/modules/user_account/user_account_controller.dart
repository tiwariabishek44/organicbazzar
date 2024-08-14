import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/model/common_response.dart';
import 'package:organicbazzar/app/modules/login/login_controller.dart';
import 'package:organicbazzar/app/repository/updatae_account_repository.dart';
import 'package:organicbazzar/app/service/api_client.dart';

class AccountController extends GetxController {
  final GlobalKey<FormState> phoneForms = GlobalKey<FormState>();
  // phone controller also
  final TextEditingController phoneController = TextEditingController();
  // address contorlller
  final TextEditingController addressController = TextEditingController();
  final loginController = Get.put(LoginController());
  // Add your controller logic here

  var isLoading = false.obs;

  final loginRepository = UpdateACcountRepository();

  void dochanges(bool isPhone) {
    if (phoneForms.currentState!.validate()) {
      dataUpdate(isPhone);
    }
  }
//--------------------  User LOGIN

  final Rx<ApiResponse<CommonResponse>> commonResponse =
      ApiResponse<CommonResponse>.initial().obs;

  Future<void> dataUpdate(bool isPhone) async {
    try {
      isLoading(true);
      commonResponse.value = ApiResponse<CommonResponse>.loading();
      final data = {
        isPhone ? "phone" : "address": isPhone
            ? phoneController.value.text.trim()
            : addressController.value.text.trim(),
      };
      final commonResult = await loginRepository.changePhone(isPhone, data);
      // log(registerResult.status.toString());

      if (commonResult.status == ApiStatus.SUCCESS) {
        commonResponse.value =
            ApiResponse<CommonResponse>.completed(commonResult.response);
        loginController.getUserData().then((value) {
          isLoading(false);
          // show success message poupo
          Get.back();
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.primaryColor,
              content: Text(isPhone
                  ? "Phone No. Update Succesfully"
                  : 'Address Updated Successfully'),
            ),
          );
        });

        log('thisis the  user data update response ${commonResult.status}');
      } else {
        isLoading.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.primaryColor,
            content: Text(commonResult.message ?? "Something went wrong"),
          ),
        );
      }
    } catch (e) {
      isLoading(false);

      log("thi is error $e");
    }
  }
}
