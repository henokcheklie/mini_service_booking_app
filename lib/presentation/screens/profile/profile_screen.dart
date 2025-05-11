import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';
import 'package:mini_service_booking_app/core/theme/theme_controller.dart';
import 'package:mini_service_booking_app/presentation/controllers/language_controller.dart';
import 'package:mini_service_booking_app/presentation/widgets/custom_back_button.dart';
import 'package:mini_service_booking_app/presentation/widgets/custom_switch_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LanguageController languageController = Get.find();
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
            vertical: kDefaultPadding / 2, horizontal: kDefaultPadding / 2),
        child: Center(
          child: Column(
            children: [
              CustomBackButton(
                icon: Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(height: kDefaultPadding * 2),
              Container(
                padding: EdgeInsets.all(kDefaultPadding * 1.5),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(kDefaultPadding)),
                child: const Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Text(
                'James Anderson',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: kDefaultPadding / 5),
              Text(
                'jameanders@example.com',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
              Text(
                '+251-91-8**-****',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),

              SizedBox(height: kDefaultPadding * 2),

              Obx(
                () => CustomSwitchTile(
                  title: "dark_mode".tr,
                  value: themeController.isDarkMode,
                  onChanged: (value) => themeController.toggleTheme(),
                  margin: kDefaultPadding,
                ),
              ),

              SizedBox(height: kDefaultPadding),

              // Language Selector
              Container(
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                ),
                child: Obx(() => ListTile(
                      title: Text(
                        "language".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      trailing: DropdownButton<String>(
                        value: languageController.locale.value.toString(),
                        borderRadius: BorderRadius.circular(kDefaultPadding),
                        underline: Container(),
                        items: [
                          DropdownMenuItem(
                            value: 'am_ET',
                            child: Text('አማርኛ'),
                          ),
                          DropdownMenuItem(
                            value: 'en_US',
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: 'fr_FR',
                            child: Text('Français'),
                          ),
                          DropdownMenuItem(
                            value: 'es_ES',
                            child: Text('Español'),
                          ),
                        ],
                        onChanged: (String? value) {
                          if (value != null) {
                            final parts = value.split('_');
                            if (parts.length == 2) {
                              languageController.changeLanguage(
                                  parts[0], parts[1]);
                            }
                          }
                        },
                      ),
                    )),
              ),
              SizedBox(height: kDefaultPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}
