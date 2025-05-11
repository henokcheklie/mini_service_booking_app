// Controller
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final RxBool showPassword = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => showPassword.toggle();

  Future<void> handleLogin() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await Future.delayed(const Duration(seconds: 2)); // Simulating API call
        customSnackbar(
          isError: false,
          message: 'login_successful'.tr,
        );
        Get.toNamed('/service/home');
      } catch (e) {
        customSnackbar(
          isError: true,
          message: 'login_failed'.tr,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
