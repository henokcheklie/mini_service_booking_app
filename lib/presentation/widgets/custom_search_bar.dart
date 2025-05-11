import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Iterable<Widget>? trailing;
  const CustomSearchBar(
      {super.key, this.controller, this.onChanged, this.trailing});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'search_service'.tr,
      controller: controller,
      leading: const Icon(Icons.search),
      onChanged: onChanged,
      trailing: trailing,
      elevation: WidgetStateProperty.all(2),
      padding: WidgetStateProperty.all(EdgeInsets.only(left: kDefaultPadding)),
      textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
      hintStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
      backgroundColor:
          WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
      ),
    );
  }
}
