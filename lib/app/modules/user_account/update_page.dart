import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/modules/user_account/user_account_controller.dart';
import 'package:organicbazzar/app/widget/custom_button.dart';
import 'package:organicbazzar/app/widget/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UpdatePage extends StatelessWidget {
  final bool isphoneChange;
  UpdatePage({Key? key, this.isphoneChange = false}) : super(key: key);

  final AccountController accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          isphoneChange ? 'Update Phone' : 'Update Address',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInstructionText(),
                  SizedBox(height: 3.h),
                  _buildInputField(),
                  SizedBox(height: 4.h),
                  _buildUpdateButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionText() {
    return Text(
      isphoneChange
          ? 'Please enter your new phone number below:'
          : 'Please enter your new address below:',
      style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
    );
  }

  Widget _buildInputField() {
    return Form(
      key: accountController.phoneForms,
      child: TextFormField(
        controller: isphoneChange
            ? accountController.phoneController
            : accountController.addressController,
        keyboardType:
            isphoneChange ? TextInputType.phone : TextInputType.streetAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            isphoneChange ? Icons.phone : Icons.location_on_outlined,
            color: AppColor.primaryColor,
          ),
          hintText: isphoneChange
              ? 'Enter your new phone number'
              : 'Enter your new address',
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return isphoneChange
                ? 'Phone number is required'
                : 'Address is required';
          }
          if (isphoneChange && value.length != 10) {
            return 'Phone number must be 10 digits';
          }
          return null;
        },
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _buildUpdateButton() {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: accountController.isLoading.value
                ? null
                : () {
                    if (accountController.phoneForms.currentState!.validate()) {
                      FocusScope.of(Get.context!).unfocus();
                      accountController.dochanges(isphoneChange);
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: accountController.isLoading.value
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Update',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
          ),
        ));
  }
}
