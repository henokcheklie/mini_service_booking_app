import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mini_service_booking_app/data/datsource/locale/service_local_datasource.dart';
import 'package:mini_service_booking_app/data/datsource/remote/service_remote_datasource.dart';
import 'package:mini_service_booking_app/data/repositories/service_repository_impl.dart';
import 'package:mini_service_booking_app/domain/usecase/add_service.dart';
import 'package:mini_service_booking_app/domain/usecase/delete_service.dart';
import 'package:mini_service_booking_app/domain/usecase/get_services.dart';
import 'package:mini_service_booking_app/domain/usecase/update_service.dart';
import 'package:mini_service_booking_app/presentation/controllers/service_controller.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    // Register data sources
    Get.lazyPut(() => ServiceRemoteDataSource());
    Get.lazyPut(() => ServiceLocalDataSource(Hive.box('services')));

    // Register repository before use cases
    Get.lazyPut(() => ServiceRepositoryImpl(
          remoteDataSource: Get.find<ServiceRemoteDataSource>(),
          localDataSource: Get.find<ServiceLocalDataSource>(),
        ));

    // Register use cases
    Get.lazyPut(() => GetServices(Get.find<ServiceRepositoryImpl>()));
    Get.lazyPut(() => AddService(Get.find<ServiceRepositoryImpl>()));
    Get.lazyPut(() => UpdateService(Get.find<ServiceRepositoryImpl>()));
    Get.lazyPut(() => DeleteService(Get.find<ServiceRepositoryImpl>()));

    // Register controller
    Get.lazyPut(() => ServiceController(
          getServices: Get.find<GetServices>(),
          addService: Get.find<AddService>(),
          updateService: Get.find<UpdateService>(),
          deleteService: Get.find<DeleteService>(),
        ));
  }
}
