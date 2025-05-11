import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LanguageController extends GetxController {
  final _box = Hive.box('settings');
  var locale = const Locale('en', 'US').obs;

  @override
  void onInit() {
    super.onInit();
    String? languageCode = _box.get('languageCode');
    String? countryCode = _box.get('countryCode');
    if (languageCode != null && countryCode != null) {
      locale.value = Locale(languageCode, countryCode);
    }
  }

  void changeLanguage(String languageCode, String countryCode) {
    locale.value = Locale(languageCode, countryCode);
    _box.put('languageCode', languageCode);
    _box.put('countryCode', countryCode);
    Get.updateLocale(locale.value);
  }
}
