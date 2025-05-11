import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/domain/entities/service.dart';
import 'package:mini_service_booking_app/presentation/controllers/service_controller.dart';
import 'package:mini_service_booking_app/presentation/widgets/service_form.dart';

class ServiceAddEditScreen extends StatelessWidget {
  final Service? service;

  const ServiceAddEditScreen({super.key, this.service});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceController>();
    return Scaffold(
      body: SafeArea(
        child: ServiceForm(
          service: service,
          controller: controller,
          onSubmit: (serviceData) async {
            if (service == null) {
              controller.addNewService(serviceData);
            } else {
              controller
                  .updateExistingService(serviceData.copyWith(id: service!.id));
            }
            Get.back();
          },
        ),
      ),
    );
  }
}
