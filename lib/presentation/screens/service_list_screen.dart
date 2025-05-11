import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';
import 'package:mini_service_booking_app/presentation/controllers/service_controller.dart';
import 'package:mini_service_booking_app/presentation/widgets/custom_back_button.dart';
import 'package:mini_service_booking_app/presentation/widgets/custom_search_bar.dart';
import 'package:mini_service_booking_app/presentation/widgets/service_card.dart';
import 'package:mini_service_booking_app/presentation/widgets/service_filter_modal.dart';

class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceController>();
    final TextEditingController searchTextController = TextEditingController();

    final String? category = Get.arguments?['category'];

    // Set the category filter when the screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (category != null && category.isNotEmpty) {
        controller.setInitialCategory(category);
      }
    });

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
            vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(
              onPressed: () {
                controller.clearFilters();
                Get.back();
              },
              icon: Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(height: kDefaultPadding * 1.5),
            Text(
              category ?? "all_services".tr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: kDefaultPadding),
            Obx(
              () => CustomSearchBar(
                controller: searchTextController,
                onChanged: (value) => controller.searchQuery.value = value,
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () =>
                        showServiceFilterModal(context, controller, true),
                  ),
                  if (controller.searchQuery.value.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchTextController.clear();
                        controller.clearFilters();
                        controller.searchQuery.value = "";
                      },
                    ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.error.value.isNotEmpty
                        ? Center(child: Text(controller.error.value))
                        : controller.filteredServices.isEmpty
                            ? Center(child: Text('no_services_found'.tr))
                            : ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding),
                                itemCount: controller.filteredServices.length,
                                itemBuilder: (context, index) {
                                  final service =
                                      controller.filteredServices[index];
                                  return ServiceCard(
                                    context: context,
                                    service: service,
                                    isHomePage: false,
                                  );
                                },
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
