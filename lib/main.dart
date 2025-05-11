import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_service_booking_app/core/constants.dart';
import 'package:mini_service_booking_app/core/theme/theme_controller.dart';
import 'package:mini_service_booking_app/core/translations/translations.dart';
import 'package:mini_service_booking_app/data/datsource/locale/service_local_datasource.dart';
import 'package:mini_service_booking_app/data/datsource/remote/service_remote_datasource.dart';
import 'package:mini_service_booking_app/data/models/service_model.dart';
import 'package:mini_service_booking_app/data/repositories/service_repository_impl.dart';
import 'package:mini_service_booking_app/domain/entities/service.dart';
import 'package:mini_service_booking_app/domain/usecase/add_service.dart';
import 'package:mini_service_booking_app/domain/usecase/delete_service.dart';
import 'package:mini_service_booking_app/domain/usecase/get_services.dart';
import 'package:mini_service_booking_app/domain/usecase/update_service.dart';
import 'package:mini_service_booking_app/presentation/bindings/service_binding.dart';
import 'package:mini_service_booking_app/presentation/controllers/language_controller.dart';
import 'package:mini_service_booking_app/presentation/controllers/login_controller.dart';
import 'package:mini_service_booking_app/presentation/controllers/service_controller.dart';
import 'package:mini_service_booking_app/presentation/screens/home_screen.dart';
import 'package:mini_service_booking_app/presentation/screens/auth/login_screren.dart';
import 'package:mini_service_booking_app/presentation/screens/profile/profile_screen.dart';
import 'package:mini_service_booking_app/presentation/screens/service_add_edit_screen.dart';
import 'package:mini_service_booking_app/presentation/screens/service_detail_screen.dart';
import 'package:mini_service_booking_app/presentation/screens/service_list_screen.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ServiceModelAdapter());
  final box = await Hive.openBox<ServiceModel>(Constants.hiveBoxName);
  await Hive.openBox('settings');

  // Initialize dependencies
  final remoteDataSource = ServiceRemoteDataSource();
  final localDataSource = ServiceLocalDataSource(box);
  final repository = ServiceRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
  final getServices = GetServices(repository);
  final addService = AddService(repository);
  final updateService = UpdateService(repository);
  final deleteService = DeleteService(repository);

  // Bind controller
  Get.put(ServiceController(
    getServices: getServices,
    addService: addService,
    updateService: updateService,
    deleteService: deleteService,
  ));

// Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Bind global controllers
  Get.put(ThemeController());
  Get.put(LoginController());
  Get.put(LanguageController());

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LanguageController languageController = Get.find();
    return Obx(() {
      return GetMaterialApp(
        title: 'Mini Service Booking App',
        theme: themeController.themeData.value,
        initialBinding: ServiceBinding(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const LoginScreen()),
          GetPage(
            name: '/service/home',
            page: () => const HomeScreen(),
          ),
          GetPage(name: '/service/list', page: () => const ServiceListScreen()),
          GetPage(
            name: '/service/add',
            page: () => const ServiceAddEditScreen(),
          ),
          GetPage(
            name: '/service/edit',
            page: () => ServiceAddEditScreen(service: Get.arguments),
          ),
          GetPage(
            name: '/service/profile',
            page: () => ProfileScreen(),
          ),
          GetPage(
            name: '/service/detail',
            page: () {
              String serviceId;
              if (Get.arguments is Map && Get.arguments['serviceId'] != null) {
                serviceId = Get.arguments['serviceId'];
              } else if (Get.arguments is Map &&
                  Get.arguments['service'] != null) {
                serviceId = (Get.arguments['service'] as Service).id!;
              } else if (Get.arguments is Service) {
                serviceId = (Get.arguments as Service).id!;
              } else {
                throw Exception('Invalid arguments for ServiceDetailScreen');
              }
              return ServiceDetailScreen(serviceId: serviceId);
            },
          ),
        ],
        translations: TranslationLanguges(),
        locale: languageController.locale.value,
        fallbackLocale: const Locale('en', 'US'),
      );
    });
  }
}
