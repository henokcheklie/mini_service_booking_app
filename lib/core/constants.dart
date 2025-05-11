import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  static const String apiBaseUrl =
      'https://682019f572e59f922ef7c703.mockapi.io/api/v1/services';
  static const String hiveBoxName = 'services';
}

const double kDefaultPadding = 16.0;
Color kBlackColor = Colors.black;
Color kWhiteColor = Colors.white;
Color kRedColor = Colors.red;
Color kGreyColor = Colors.grey;

SnackbarController customSnackbar(
    {required bool isError, String? title, required String message}) {
  return Get.snackbar(
    title ?? (isError ? 'error'.tr : 'success'.tr),
    message,
    snackPosition: SnackPosition.TOP,
    colorText: Colors.white,
    backgroundColor: isError ? Get.theme.colorScheme.error : Colors.green,
  );
}

InputDecoration customInputDecoration(
    {required BuildContext context, required String labelText}) {
  return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .inversePrimary
                  .withValues(alpha: 0.6)),
          borderRadius: BorderRadius.circular(kDefaultPadding)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .inversePrimary
                  .withValues(alpha: 0.6)),
          borderRadius: BorderRadius.circular(kDefaultPadding)),
      filled: true,
      fillColor: Theme.of(context).colorScheme.secondary,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      hintStyle: TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
      ));
}

ButtonStyle buttonStyle(
    {required BuildContext context, double? width, double? height}) {
  return ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
          Theme.of(context).colorScheme.inversePrimary),
      foregroundColor: WidgetStateProperty.all<Color>(
          Theme.of(context).colorScheme.secondary),
      minimumSize: WidgetStateProperty.all<Size>(
          Size(width ?? kDefaultPadding * 10, height ?? kDefaultPadding * 2)),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: kDefaultPadding)),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultPadding)),
      ));
}

// Fixed categories and subcategories
final Map<String, List<String>> categories = {
  'Home Services': [
    'Cleaning',
    'Plumbing',
    'Electrical work',
    'Handyman services',
    'Appliance repair',
    'Pest control',
    'Painting',
    'Carpentry',
    'Interior design',
  ],
  'Beauty & Wellness': [
    'Haircut & Styling',
    'Makeup artist',
    'Spa & Massage',
    'Manicure & Pedicure',
    'Skincare / Facial',
    'Personal trainer',
    'Yoga instructor',
  ],
  'Automotive': [
    'Car wash & detailing',
    'Vehicle repair',
    'Oil change',
    'Tire replacement',
    'Car towing',
    'Mobile mechanic',
  ],
  'Childcare & Elder Care': [
    'Babysitting',
    'Nanny services',
    'Elderly care',
    'Special needs assistance',
    'Tutoring',
  ],
  'Pet Services': [
    'Pet grooming',
    'Dog walking',
    'Pet sitting',
    'Veterinary appointments',
    'Pet training',
  ],
  'Real Estate & Moving': [
    'Property inspection',
    'Home staging',
    'Moving & packing',
    'Storage services',
  ],
  'Professional Services': [
    'IT support',
    'Legal consultation',
    'Accounting & bookkeeping',
    'Tax filing',
    'Business consultancy',
    'Language translation',
  ],
  'Events & Entertainment': [
    'Event planning',
    'DJ services',
    'Photography/Videography',
    'Catering',
    'Decoration services',
    'Party equipment rental',
  ],
  'Education & Training': [
    'Private tutoring',
    'Test preparation',
    'Online classes',
    'Language learning',
    'Music lessons',
    'Art & craft classes',
  ],
  'Health & Therapy': [
    'Physiotherapy',
    'Mental health counseling',
    'Nutritionist/Dietitian',
    'Chiropractic care',
    'Acupuncture',
  ],
  'Travel & Hospitality': [
    'Tour guides',
    'Travel planning',
    'Hotel booking',
    'Airport pickup/drop',
    'Vehicle rental',
  ],
};
