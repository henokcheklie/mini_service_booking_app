import 'package:mini_service_booking_app/domain/entities/service.dart';

abstract class ServiceRepository {
  Future<List<Service>> getServices();
  Future<Service> addService(Service service);
  Future<Service> updateService(Service service);
  Future<void> deleteService(String id);
}
