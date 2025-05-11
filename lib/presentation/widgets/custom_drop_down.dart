import 'package:flutter/material.dart';
import 'package:mini_service_booking_app/core/constants.dart';

class CustomDropDown extends StatelessWidget {
  final String value;
  final String title;
  final ValueChanged<String?>? onChanged;
  final List<DropdownMenuItem<String>>? items;
  const CustomDropDown(
      {super.key,
      this.onChanged,
      required this.items,
      required this.value,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: kDefaultPadding / 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 4, vertical: kDefaultPadding / 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            iconSize: 20,
            borderRadius: BorderRadius.circular(kDefaultPadding),
            style: TextStyle(
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            underline: const SizedBox(),
            items: items,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
