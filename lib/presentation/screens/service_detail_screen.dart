import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';
import 'package:mini_service_booking_app/domain/entities/service.dart';
import 'package:mini_service_booking_app/presentation/controllers/service_controller.dart';
import 'package:mini_service_booking_app/presentation/widgets/custom_back_button.dart';
import 'package:mini_service_booking_app/presentation/widgets/image_loader.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ServiceDetailScreen extends StatelessWidget {
  final String serviceId;

  const ServiceDetailScreen({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceController>();
    final theme = Theme.of(context).colorScheme;

    return Obx(() {
      // Fetch the service by ID from the services list
      final service = controller.services.firstWhere(
        (s) => s.id == serviceId,
        orElse: () => Service(
          id: serviceId,
          name: 'service_not_found'.tr,
          category: '',
          price: 0.0,
          duration: 0,
          rating: 0.0,
          availability: false,
          imageUrl: '',
        ),
      );

      return Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              Card(
                color: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: kDefaultPadding),
                      _buildServiceHeader(service),
                      _buildDetailRow('category'.tr, service.category),
                      _buildDetailRow('price'.tr,
                          "${service.price.toStringAsFixed(2)} ${'etb'.tr}"),
                      _buildDetailRow('duration_label'.tr,
                          "${service.duration} ${'minutes'.tr}"),
                      _buildDetailRow(
                          'rating_label'.tr,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SmoothStarRating(
                                rating: service.rating,
                                size: 20,
                                starCount: 5,
                                color: Colors.orange,
                                borderColor: Colors.orange,
                              ),
                              const SizedBox(width: 8),
                              Text(service.rating.toStringAsFixed(1)),
                            ],
                          )),
                      _buildDetailRow(
                          'availability'.tr,
                          Chip(
                            label: Text(
                              service.availability
                                  ? 'available'.tr
                                  : 'unavailable'.tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: service.availability
                                ? Colors.green
                                : theme.error,
                          )),
                      const Divider(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () {
                                Get.toNamed('/service/edit',
                                    arguments: service);
                              },
                              icon: Icon(Icons.edit, color: theme.shadow),
                              label: Text('edit'.tr,
                                  style: TextStyle(color: theme.shadow)),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: 'delete_service'.tr,
                                  middleText:
                                      "${'confirm_delete'.tr} ${service.name}",
                                  onConfirm: () {
                                    controller
                                        .deleteExistingService(service.id!);
                                    Get.back();
                                    Get.back();
                                  },
                                  onCancel: () {},
                                  backgroundColor: theme.secondary,
                                  buttonColor: theme.error,
                                  cancelTextColor: theme.onSurface,
                                  confirmTextColor: theme.onError,
                                );
                              },
                              icon: Icon(Icons.delete, color: theme.shadow),
                              label: Text('delete'.tr,
                                  style: TextStyle(color: theme.shadow)),
                              style: FilledButton.styleFrom(
                                backgroundColor: theme.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildServiceHeader(Service service) {
    final isValidUrl = RegExp(r'^https?://').hasMatch(service.imageUrl);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'service-${service.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ImageLoader(
                imageUrl: service.imageUrl,
                isValidUrl: isValidUrl,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String title, dynamic value) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      trailing: value is Widget
          ? value
          : Text(
              value.toString(),
              style: const TextStyle(fontSize: 16),
            ),
    );
  }
}
