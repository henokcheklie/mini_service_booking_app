import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';

class CustomBackButton extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final IconData? icon;
  final Function()? onPressed;
  const CustomBackButton(
      {super.key, this.color, this.backgroundColor, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(icon ?? Icons.arrow_back_ios),
          onPressed: onPressed ??
              () {
                Get.back();
              },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
                backgroundColor ?? Colors.transparent),
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(kDefaultPadding / 2),
            ),
          ),
        ),
      ],
    );
  }
}
