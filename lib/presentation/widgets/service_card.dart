import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';
import 'package:mini_service_booking_app/domain/entities/service.dart';
import 'package:mini_service_booking_app/presentation/controllers/service_controller.dart';
import 'package:mini_service_booking_app/presentation/widgets/image_loader.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  final BuildContext context;
  final bool? isHomePage;

  const ServiceCard(
      {super.key,
      required this.service,
      this.isHomePage,
      required this.context});

  @override
  Widget build(BuildContext context) {
    final isValidUrl = RegExp(r'^https?://').hasMatch(service.imageUrl);
    return isHomePage!
        ? _buildVerticalCard(isValidUrl)
        : _buildHorizontalCard(isValidUrl, context);
  }

  Widget _buildVerticalCard(bool isValidUrl) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: () {
          Get.toNamed('/service/detail', arguments: {'serviceId': service.id});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(kDefaultPadding)),
              child: Hero(
                tag: 'service-${service.id}-home',
                child: SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: ImageLoader(
                    imageUrl: service.imageUrl,
                    isValidUrl: isValidUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Column(
                spacing: kDefaultPadding / 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    service.category,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  Text('${'etb'.tr} ${service.price.toStringAsFixed(2)}'),
                  SmoothStarRating(
                    rating: service.rating,
                    size: 14,
                    starCount: 5,
                    color: Colors.yellow[700],
                    borderColor: Colors.yellow[700],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCard(bool isValidUrl, BuildContext context) {
    final controller = Get.find<ServiceController>();
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      margin: EdgeInsets.only(bottom: isHomePage! ? 0 : kDefaultPadding / 2),
      child: InkWell(
        onTap: () {
          Get.toNamed('/service/detail', arguments: {'serviceId': service.id});
        },
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          leading: SizedBox(
            width: 100,
            height: 100,
            child: Hero(
              tag: 'service-${service.id}',
              child: ImageLoader(
                imageUrl: service.imageUrl,
                isValidUrl: isValidUrl,
              ),
            ),
          ),
          title: Text(
            service.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                    spacing: kDefaultPadding / 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.category,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      Text(
                        '\$${service.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      SmoothStarRating(
                        rating: service.rating,
                        size: kDefaultPadding * 0.8,
                        starCount: 5,
                        color: Colors.yellow[700],
                        borderColor: Colors.yellow[700],
                      ),
                    ]),
              ),
              IconButton(
                icon: Icon(
                  size: 20,
                  Icons.edit,
                ),
                onPressed: () =>
                    Get.toNamed('/service/edit', arguments: service),
                tooltip: 'edit_service_action'.tr,
              ),
              IconButton(
                icon: Icon(
                    size: 20,
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error),
                onPressed: () => Get.defaultDialog(
                    title: 'delete_service_action'.tr,
                    middleText: "${'confirm_delete_card'.tr} ${service.name}?",
                    onConfirm: () {
                      controller.deleteExistingService(service.id!);
                      Get.back(); // Close dialog
                      Get.back(); // Navigate back
                    },
                    onCancel: () {},
                    buttonColor: Theme.of(context).colorScheme.error,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    confirmTextColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    cancelTextColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    contentPadding: EdgeInsets.all(kDefaultPadding)),
                tooltip: 'delete_service_action'.tr,
              ),
            ],
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
