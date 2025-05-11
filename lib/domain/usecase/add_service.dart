import 'package:mini_service_booking_app/domain/entities/service.dart';
import 'package:mini_service_booking_app/domain/repositories/service_repository.dart';

class AddService {
  final ServiceRepository repository;

  AddService(this.repository);

  Future<Service> call(Service service) async {
    return await repository.addService(service);
  }
}
