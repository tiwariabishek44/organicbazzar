import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/forget_password/forget_password.dart';
import 'package:organicbazzar/app/modules/home/home_page.dart';
import 'package:organicbazzar/app/modules/login/login_controller.dart';
import 'package:organicbazzar/app/modules/register/register_page.dart';
import 'package:organicbazzar/app/widget/custom_button.dart';
import 'package:organicbazzar/app/widget/loading_widget.dart';
import 'package:organicbazzar/app/widget/text_form_field.dart';
import 'package:organicbazzar/app/widget/welcome_heading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: AppPadding.screenHorizontalPadding,
              child: Form(
                key: loginController.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    WelcomeHeading(
                        mainHeading: 'Welcome to Organic Bazzar',
                        subHeading: 'Please login to your account to continue'),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormFieldWidget(
                      textInputType: TextInputType.emailAddress,
                      hintText: "Email",
                      controller: loginController.emailController,
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
                    SizedBox(
                      height: 3.h,
                    ),
                    Obx(
                      () => TextFormFieldWidget(
                        prefixIcon: const Icon(Icons.lock),
                        textInputType: TextInputType.text,
                        hintText: 'Password',
                        controller: loginController.passwordController,
                        obscureText: !loginController.isPasswordVisible.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            loginController.isPasswordVisible.value =
                                !loginController.isPasswordVisible.value;
                          },
                          icon: Icon(
                            loginController.isPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
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
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ForgetPasswordPage(),
                                transition: Transition.cupertinoDialog,
                                duration: pageTransitionDuration);
                          },
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                color: const Color(0xff6A707C),
                                fontSize: 15.sp,
                              )),
                        ),
                      ),
                    ),
                    CustomButton(
                      buttonColor: AppColor.primaryColor,
                      textColor: Colors.white,
                      text: "Login",
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        loginController.loginUser(context);
                      },
                      isLoading: false,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Expanded(
                            child: Divider(
                              color: Color.fromARGB(255, 217, 214, 214),
                              height: 0.2,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'OR',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xff6A707C),
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: Color.fromARGB(255, 217, 214, 214),
                              height: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(() => RegisterView(),
                                transition: Transition.cupertinoDialog,
                                duration: pageTransitionDuration);
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() => loginController.isLoading.value
            ? Positioned(
                left: 40.w,
                top: 50.h,
                child: const Center(child: LoadingWidget()))
            : SizedBox.shrink())
      ],
    );
  }
}
