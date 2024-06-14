import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final mobileNumberController = TextEditingController();

  var isloading = false.obs;
  var ispasswordvisible = false.obs;
  var termsandcondition = false.obs;

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
