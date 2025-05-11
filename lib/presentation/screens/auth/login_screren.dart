import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';
import 'package:mini_service_booking_app/core/utils/validators.dart';
import 'package:mini_service_booking_app/presentation/controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 210,
                height: 210,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kDefaultPadding * 6),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.inversePrimary.withValues(alpha: 0.13),
                      ),
                      child: Icon(
                        Icons.account_circle,
                        size: kDefaultPadding * 5,
                        color: theme.inversePrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Center(
                    child: Text(
                      'welcome_back'.tr,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.inversePrimary,
                              ),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 1.5),
                  Center(
                    child: Text(
                      'login_to_your_account'.tr,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: theme.inversePrimary.withValues(alpha: 0.7),
                          ),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  Padding(
                    padding: const EdgeInsets.only(
                          left: kDefaultPadding / 2,
                          right: kDefaultPadding / 2,
                          top: kDefaultPadding,
                        ) *
                        2,
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: controller.emailController,
                            focusNode: controller.emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: customInputDecoration(
                              labelText: 'email'.tr,
                              context: context,
                            ).copyWith(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: theme.inversePrimary,
                              ),
                            ),
                            validator: Validators.validateEmail,
                          ),
                          const SizedBox(height: kDefaultPadding * 1.5),
                          Obx(() => TextFormField(
                                controller: controller.passwordController,
                                focusNode: controller.passwordFocusNode,
                                obscureText: !controller.showPassword.value,
                                decoration: customInputDecoration(
                                  labelText: 'password'.tr,
                                  context: context,
                                ).copyWith(
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: theme.inversePrimary,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.showPassword.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: theme.inversePrimary,
                                    ),
                                    onPressed:
                                        controller.togglePasswordVisibility,
                                  ),
                                ),
                                validator: Validators.validatePassword,
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'forgot_password'.tr,
                                style: TextStyle(
                                  color: theme.inversePrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding * 2),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: Obx(() => ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.handleLogin,
                                  style: buttonStyle(
                                      context: context,
                                      height: kDefaultPadding * 3),
                                  child: controller.isLoading.value
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: theme.secondary,
                                          ),
                                        )
                                      : Text(
                                          'login'.tr,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: theme.secondary,
                                          ),
                                        ),
                                )),
                          ),
                          const SizedBox(height: kDefaultPadding / 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "dont_have_account".tr,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'signup'.tr,
                                  style: TextStyle(
                                    color: theme.inversePrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
