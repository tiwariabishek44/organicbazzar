import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/prefs.dart';
import 'package:organicbazzar/app/model/device_registration.dart';
import 'package:organicbazzar/app/model/login_api_response.dart';
import 'package:organicbazzar/app/model/user_data_response.dart';
import 'package:organicbazzar/app/modules/home/home_page.dart';
import 'package:organicbazzar/app/modules/latest_product/latest_proudct_controller.dart';
import 'package:organicbazzar/app/modules/our_product/our_product_controller.dart';
import 'package:organicbazzar/app/repository/deivce_register_repository.dart';
import 'package:organicbazzar/app/repository/get_user_data_repositoyr.dart';
import 'package:organicbazzar/app/repository/login_repository.dart';
import 'package:organicbazzar/app/service/api_client.dart';
import 'package:organicbazzar/app/utils/token_utils.dart';
import 'package:organicbazzar/app/widget/custom_snackbar.dart';
import 'package:organicbazzar/app/widget/splash_screen.dart';

class LoginController extends GetxController {
  final storage = GetStorage();
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  final latestProductController = Get.put(LatestProductController());
  final ourProductController = Get.put(OurProductController());
  void loginUser(BuildContext context) {
    if (loginFormKey.currentState!.validate()) {
      login();
    }
  }

  final LoginRepository loginRepository = LoginRepository();

//--------------------  User LOGIN

  final Rx<ApiResponse<LoginApiResponse>> loginApiResponse =
      ApiResponse<LoginApiResponse>.initial().obs;

  Future<void> login() async {
    try {
      isLoading(true);
      loginApiResponse.value = ApiResponse<LoginApiResponse>.loading();
      final user = {
        "email": emailController.value.text.trim(),
        "password": passwordController.value.text.trim(),
      };
      final loginResult = await loginRepository.loginUser(user);
      // log(registerResult.status.toString());

      if (loginResult.status == ApiStatus.SUCCESS) {
        loginApiResponse.value =
            ApiResponse<LoginApiResponse>.completed(loginResult.response);

        saveDataLocally(loginResult.response?.data!.accessToken.toString(),
            loginResult.response?.data!.refreshToken.toString());

        isLoading(false);
      } else {
        isLoading.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            backgroundColor: Color.fromARGB(255, 200, 71, 32),
            content: Text(loginResult.message.toString()),
          ),
        );
      }
    } catch (e) {
      isLoading(false);

      log("thi is error $e");
    }
  }
//------------------To get The user data

  final userDataReposityr = Get.put(GetUserDataRepository());
  final Rx<ApiResponse<UserDataResponse>> userDataResponse =
      ApiResponse<UserDataResponse>.initial().obs;
  var userdataFetched = false.obs;
  Future<void> getUserData() async {
    try {
      userdataFetched.value = false;
      userDataResponse.value = ApiResponse<UserDataResponse>.loading();
      final userResult = await userDataReposityr.getUserData();
      if (userResult.status == ApiStatus.SUCCESS) {
        userDataResponse.value =
            ApiResponse<UserDataResponse>.completed(userResult.response);
        userDataResponse.value.response!.data.id.toString() != ''
            ? userdataFetched.value = true
            : userdataFetched.value = false;
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.primaryColor,
            content: Text(userResult.message.toString()),
          ),
        );
        log("${userResult.message}");
      }
    } catch (e) {
      log("${e.toString()}");
    }
  }

//---------TO SAVE USER DATA LOCALLY--------------
  void saveDataLocally(
    String? accessToken,
    String? refreshToken,
  ) async {
    storage.write("isLogin", 'TRUE');
    await TokenManager.setAccessToken(accessToken);
    await TokenManager.setRefreshToken(refreshToken!);

    await Future.wait([
      getUserData(),
      latestProductController.getLatestItems(),
      ourProductController.getRegularProducts(),
    ]);
    Get.offAll(
      () => HomePage(),
    );
  }

//---------------USER LOGOUT------------
  void logout() async {
    await TokenManager.deleteTokens();
    await storage.remove("cartItems");
    storage.remove("isLogin");
    Get.offAll(SplashScreen());
  }

//------------TO CHECK IS USER IS LOG IN OR NOT------------
  bool isLogedIn() {
    log(" The device is loign    ${storage.read("isLogin")}");

    log(" The device is loign    ${storage.read("deviceId")}");

    if (storage.read("isLogin") == 'TRUE') {
      return true;
    } else {
      return false;
    }
  }

  // ---------------- to register deice id

  final DeviceRegistrationRepository deviceRegistrationRepo =
      DeviceRegistrationRepository();

//--------------------  User LOGIN

  final Rx<ApiResponse<DeviceRegistrationResponse>> deviceRegistrationResponse =
      ApiResponse<DeviceRegistrationResponse>.initial().obs;

  Future<void> registerDevice() async {
    try {
      deviceRegistrationResponse.value =
          ApiResponse<DeviceRegistrationResponse>.loading();
      final user = {"deviceToken": storage.read("deviceId")};
      final registerResult = await deviceRegistrationRepo.registerDevice(user);

      if (registerResult.status == ApiStatus.SUCCESS) {
        log(':::::::::::::::::::::::::: the registration is succesfully happen');
        log(":::::::::::::::::::::::::: Android device token: ${storage.read('deviceId')}");
      } else {
        log(' the  device token registration failler');
      }
    } catch (e) {
      log("thi is error $e");
    }
  }
}
