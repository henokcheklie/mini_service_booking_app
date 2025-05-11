import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';
import 'package:mini_service_booking_app/domain/entities/service.dart';
import 'package:mini_service_booking_app/presentation/controllers/service_controller.dart';
import 'package:mini_service_booking_app/presentation/widgets/custom_search_bar.dart';
import 'package:mini_service_booking_app/presentation/widgets/service_card.dart';
import 'package:mini_service_booking_app/presentation/widgets/service_filter_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    final controller = Get.find<ServiceController>();
    final TextEditingController searchTextController = TextEditingController();

    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: RefreshIndicator(
            color: theme.secondary,
            backgroundColor: theme.primary,
            onRefresh: () async {
              await controller.fetchServices();
            },
            child: Column(
              children: [
                ///header
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getGreeting(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "simplify_your_day".tr,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed('service/profile'),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: theme.secondary,
                          child: Icon(
                            Icons.person,
                            size: 38,
                            color: theme.inversePrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                          color: theme.inversePrimary,
                        ))
                      : controller.error.value.isNotEmpty
                          ? Expanded(
                              child: Center(
                                  child: Text('error_loading_services'.tr)),
                            )
                          : Column(
                              spacing: kDefaultPadding,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  child: CustomSearchBar(
                                    controller: searchTextController,
                                    onChanged: (value) =>
                                        controller.searchQuery.value = value,
                                    trailing: [
                                      IconButton(
                                        icon: const Icon(Icons.tune),
                                        onPressed: () => showServiceFilterModal(
                                            context, controller, false),
                                      ),
                                      if (controller
                                          .searchQuery.value.isNotEmpty)
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
                                  child: _buildServicesByCategory(controller),
                                ),
                              ],
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed('/service/add'),
        icon: const Icon(Icons.add),
        label: Text('add_service'.tr),
        backgroundColor: theme.inversePrimary,
        foregroundColor: theme.secondary,
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'good_morning'.tr;
    if (hour < 18) return 'good_afternoon'.tr;
    return 'good_evening'.tr;
  }

  Widget _buildServicesByCategory(ServiceController controller) {
    final Map<String, List<Service>> servicesByCategory = {};

    final filteredServices = controller.services.where((service) {
      final matchesSearch = controller.searchQuery.value.isEmpty ||
          service.name
              .toLowerCase()
              .contains(controller.searchQuery.value.toLowerCase());

      final matchesCategory = controller.selectedCategory.value.isEmpty ||
          service.category == controller.selectedCategory.value;

      final matchesPrice = service.price >= controller.priceRange.value.start &&
          service.price <= controller.priceRange.value.end;

      return matchesSearch && matchesCategory && matchesPrice;
    }).toList();

    for (var service in filteredServices) {
      servicesByCategory.putIfAbsent(service.category, () => []).add(service);
    }

    if (!controller.isLoading.value &&
        controller.error.value.isEmpty &&
        servicesByCategory.isEmpty) {
      return Center(child: Text('no_services_found'.tr));
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      itemCount: servicesByCategory.length,
      separatorBuilder: (_, __) => const SizedBox(height: kDefaultPadding),
      itemBuilder: (context, index) {
        final category = servicesByCategory.keys.elementAt(index);
        final services = servicesByCategory[category]!;

        return Column(
          spacing: kDefaultPadding / 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: 1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (services.length >= 4)
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/service/list',
                            arguments: {'category': category});
                      },
                      child: Text(
                        'see_more'.tr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                itemCount: services.length,
                separatorBuilder: (_, __) => const SizedBox(width: 1),
                itemBuilder: (context, serviceIndex) {
                  return SizedBox(
                    width: 250,
                    child: ServiceCard(
                      context: context,
                      service: services[serviceIndex],
                      isHomePage: true,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
