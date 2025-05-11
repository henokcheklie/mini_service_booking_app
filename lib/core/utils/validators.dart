import 'package:get/get.dart';

class Validators {
  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) return 'price_required'.tr;
    if (double.tryParse(value) == null || double.parse(value) <= 0) {
      return 'enter_valid_price'.tr;
    }
    return null;
  }

  static String? validateImageUrl(String? value) {
    if (value!.isEmpty) return 'image_url_required'.tr;
    if (!RegExp(r'^https?://').hasMatch(value)) {
      return 'enter_valid_image_url'.tr;
    }
    return null;
  }

  static String? validateDuration(String? value) {
    if (value == null || value.isEmpty) return 'duration_required'.tr;
    if (int.tryParse(value) == null || int.parse(value) <= 0) {
      return 'enter_valid_duration'.tr;
    }
    return null;
  }

  static String? validateRating(String? value) {
    if (value == null || value.isEmpty) return 'rating_required'.tr;
    final rating = double.tryParse(value);
    if (rating == null || rating < 0 || rating > 5) {
      return 'rating_between_0_5'.tr;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'email_required'.tr;
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'enter_valid_email'.tr;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final RegExp passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    if (value == null || value.isEmpty) return 'password_required'.tr;
    if (!passwordRegex.hasMatch(value)) {
      return 'password_validation_message'.tr;
    }
    return null;
  }
}
