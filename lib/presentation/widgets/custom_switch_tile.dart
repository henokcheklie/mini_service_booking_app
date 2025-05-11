import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_service_booking_app/core/constants.dart';

class CustomSwitchTile extends StatelessWidget {
  final bool value;
  final String title;
  final double? margin;
  final void Function(bool)? onChanged;
  const CustomSwitchTile(
      {super.key,
      required this.value,
      this.onChanged,
      required this.title,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
      margin: EdgeInsets.all(margin ?? 0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
