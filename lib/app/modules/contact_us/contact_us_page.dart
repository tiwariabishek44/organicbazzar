import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/contact_us/contact_us_controller.dart';
import 'package:organicbazzar/app/widget/custom_button.dart';
import 'package:organicbazzar/app/widget/text_form_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContactUsPage extends StatelessWidget {
  final contactUsController = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contact Us'),
        ),
        body: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: ListView(
            children: [
              Padding(
                padding: AppPadding.screenHorizontalPadding,
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(31, 0, 0, 0),
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(children: [
                      TextFormFieldWidget(
                        showIcons: false,
                        textInputType: TextInputType.text,
                        hintText: "Name",
                        controller: contactUsController.nameController,
                        validatorFunction: (value) {
                          if (value.isEmpty) {
                            return "Name  is required";
                          }
                          return null;
                        },
                        actionKeyboard: TextInputAction.next,
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormFieldWidget(
                        showIcons: false,
                        textInputType: TextInputType.text,
                        hintText: "Phone",
                        controller: contactUsController.phoneContorlller,
                        validatorFunction: (value) {
                          if (value.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        },
                        actionKeyboard: TextInputAction.next,
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormFieldWidget(
                        showIcons: false,
                        textInputType: TextInputType.text,
                        hintText: "Email",
                        controller: contactUsController.nameController,
                        validatorFunction: (value) {
                          if (value.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        },
                        actionKeyboard: TextInputAction.next,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextField(
                        controller: contactUsController.nameController,
                        cursorColor: Colors.black,
                        textAlign: TextAlign.left,
                        maxLines:
                            4, // This will make the TextField 4 lines tall

                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.all(2.h),
                          filled: true,
                          fillColor: Color.fromARGB(24, 152, 151, 151),
                          border: InputBorder.none,
                          hintText: 'Enter your message',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomButton(
                        buttonColor: AppColor.primaryColor,
                        textColor: AppColor.backgroundColor,
                        text: "SUBMIT",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                        isLoading: false,
                      ),
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Contact Admin Information:',
                            style: TextStyle(
                              fontSize: 20, // Increase the font size
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Phone: +973838838383',
                            style: TextStyle(
                              color: Colors.grey[800], // Grey toward black
                            ),
                          ),
                          Text(
                            'Email: slls@gmail.com',
                            style: TextStyle(
                              color: Colors.grey[800], // Grey toward black
                            ),
                          ),
                          Text(
                            'Address: timkune-32, kathmandu',
                            style: TextStyle(
                              color: Colors.grey[800], // Grey toward black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
