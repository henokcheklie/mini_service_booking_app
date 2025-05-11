import '../entities/service.dart';
import '../repositories/service_repository.dart';

class UpdateService {
  final ServiceRepository repository;

  UpdateService(this.repository);

  Future<Service> call(Service service) async {
    return await repository.updateService(service);
  }
}
