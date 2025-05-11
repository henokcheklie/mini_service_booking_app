import '../repositories/service_repository.dart';

class DeleteService {
  final ServiceRepository repository;

  DeleteService(this.repository);

  Future<void> call(String id) async {
    await repository.deleteService(id);
  }
}
