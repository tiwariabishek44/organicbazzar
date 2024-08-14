import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/model/contact_us_response.dart';
import 'package:organicbazzar/app/repository/contact_us_repository.dart';
import 'package:organicbazzar/app/widget/custom_snackbar.dart';

import '../../service/api_client.dart';

class ContactUsController extends GetxController {
  var isInquiryLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  var inquiryResponse = ApiResponse<ContactUsResponse>.initial().obs;
  final inquiryRepo = ContactUsRepository();

  final nameController = TextEditingController();
  final phoneContorlller = TextEditingController();

  void productInqury(int productId) {
    if (formKey.currentState!.validate()) {
      inquiry(productId: productId);
    }
  }

  Future<void> inquiry({
    required int productId,
  }) async {
    isInquiryLoading.value = true;
    log(productId.toString());

    final body = {
      "bookId": productId,
      "name": nameController.text.trim(),
      "phoneNumber": phoneContorlller.text.trim(),
      "message": ' i want to buy this product'
    };

    try {
      final response = await inquiryRepo.inquiry(body);
      inquiryResponse.value = response;

      //==============Observe the API Response ===========
      if (response.status == ApiStatus.SUCCESS) {
        CustomSnackBar.showSuccess('Inqury is send succesfully');
      } else {
        CustomSnackBar.showFailure('${response.message}');
      }
    } catch (e) {
      log("Error occurred: $e");
      CustomSnackBar.showFailure('Error occurred: $e');
    } finally {
      isInquiryLoading.value = false;
    }
  }
}
