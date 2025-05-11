import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';
import 'package:mini_service_booking_app/domain/entities/service.dart';
import 'package:mini_service_booking_app/domain/usecase/add_service.dart';
import 'package:mini_service_booking_app/domain/usecase/delete_service.dart';
import 'package:mini_service_booking_app/domain/usecase/get_services.dart';
import 'package:mini_service_booking_app/domain/usecase/update_service.dart';

class ServiceController extends GetxController {
  final GetServices getServices;
  final AddService addService;
  final UpdateService updateService;
  final DeleteService deleteService;

  ServiceController({
    required this.getServices,
    required this.addService,
    required this.updateService,
    required this.deleteService,
  });

  final services = <Service>[].obs;
  final filteredServices = <Service>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final searchQuery = ''.obs;
  final priceRange = const RangeValues(0, 500).obs;
  final selectedCategory = ''.obs;
  final categories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchServices();
    searchQuery.listen((_) => applyFilters());
  }

  void setInitialCategory(String? category) {
    if (category != null && selectedCategory.value != category) {
      selectedCategory.value = category;
      applyFilters();
    }
  }

  Future<void> fetchServices() async {
    isLoading.value = true;
    try {
      final result = await getServices();
      services.assignAll(result);
      // Extract unique categories
      categories.assignAll(
        result.map((service) => service.category).toSet().toList()..sort(),
      );
      applyFilters();
      error.value = '';
    } catch (e) {
      error.value = e.toString();
      customSnackbar(
        isError: true,
        message: " ${'failed_to_load_service'.tr}: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addNewService(Service service) async {
    isLoading.value = true;
    try {
      await addService(service);
      await fetchServices(); // Refresh the list
      customSnackbar(
        isError: false,
        message: 'service_added_successfully'.tr,
      );
      error.value = '';
    } catch (e) {
      error.value = e.toString();
      customSnackbar(
        isError: true,
        title: 'Error',
        message: " ${'failed_to_add_service'.tr}: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateExistingService(Service service) async {
    isLoading.value = true;
    try {
      await updateService(service);
      await fetchServices();

      customSnackbar(
        isError: false,
        message: 'service_updated_successfully'.tr,
      );
      error.value = '';
    } catch (e) {
      error.value = e.toString();
      customSnackbar(
        isError: true,
        message: " ${'failed_to_update_service'.tr}: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteExistingService(String id) async {
    isLoading.value = true;
    try {
      await deleteService(id);
      await fetchServices();
      customSnackbar(
        isError: false,
        message: 'service_deleted_successfully'.tr,
      );
      error.value = '';
    } catch (e) {
      error.value = e.toString();
      customSnackbar(
        isError: true,
        message: " ${'failed_to_delete_service'.tr}: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters() {
    filteredServices.assignAll(
      services.where((service) {
        final matchesSearch = searchQuery.value.isEmpty ||
            service.name
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            service.category
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase());
        final matchesPrice = service.price >= priceRange.value.start &&
            service.price <= priceRange.value.end;
        final matchesCategory = selectedCategory.value.isEmpty ||
            service.category == selectedCategory.value;
        return matchesSearch && matchesPrice && matchesCategory;
      }).toList(),
    );
  }

  // Method that clears all filters
  void clearFilters() {
    priceRange.value = const RangeValues(0, 500);
    selectedCategory.value = '';
    searchQuery.value = '';
    applyFilters();
  }

  // New method that clears only search and price filters but keeps category
  void clearSearchAndPriceFilters() {
    priceRange.value = const RangeValues(0, 500);
    searchQuery.value = '';
    applyFilters();
  }

  // Method to clear only search query
  void clearSearchQuery() {
    searchQuery.value = '';
    applyFilters();
  }
}
