import 'package:hive/hive.dart';
import 'package:mini_service_booking_app/data/models/service_model.dart';

class ServiceLocalDataSource {
  final Box<ServiceModel> box;

  ServiceLocalDataSource(this.box);

  Future<void> cacheServices(List<ServiceModel> services) async {
    await box.clear();
    await box.addAll(services);
  }

  List<ServiceModel> getCachedServices() {
    return box.values.toList();
  }
}
