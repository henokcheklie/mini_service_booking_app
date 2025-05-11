import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';
import 'package:mini_service_booking_app/presentation/controllers/service_controller.dart';

void showServiceFilterModal(
    BuildContext context, ServiceController controller, bool islist) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(kDefaultPadding * 1.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'filter_services'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: kDefaultPadding),
            Text('price_range'.tr),
            Obx(
              () => RangeSlider(
                values: controller.priceRange.value,
                min: 0,
                max: 500,
                divisions: 50,
                activeColor: Colors.green,
                labels: RangeLabels(
                  '\$${controller.priceRange.value.start.round()}',
                  '\$${controller.priceRange.value.end.round()}',
                ),
                onChanged: (RangeValues values) {
                  controller.priceRange.value = values;
                },
              ),
            ),
            SizedBox(height: kDefaultPadding),
            if (!islist) Text('category'.tr),
            if (!islist)
              Obx(
                () => DropdownButton<String>(
                  isExpanded: true,
                  value: controller.selectedCategory.value.isEmpty
                      ? null
                      : controller.selectedCategory.value,
                  hint: Text('select_category'.tr),
                  items: controller.categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedCategory.value = value ?? '';
                  },
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  dropdownColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
            SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.clearFilters();
                    Get.back();
                  },
                  style: buttonStyle(context: context),
                  child: Text('clear'.tr),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.applyFilters();
                    Get.back();
                  },
                  style: buttonStyle(context: context),
                  child: Text('apply'.tr),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
