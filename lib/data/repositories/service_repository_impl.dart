import 'package:mini_service_booking_app/data/datsource/locale/service_local_datasource.dart';
import 'package:mini_service_booking_app/data/datsource/remote/service_remote_datasource.dart';
import 'package:mini_service_booking_app/data/models/service_model.dart';
import 'package:mini_service_booking_app/domain/entities/service.dart';
import 'package:mini_service_booking_app/domain/repositories/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource remoteDataSource;
  final ServiceLocalDataSource localDataSource;

  ServiceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Service>> getServices() async {
    try {
      final services = await remoteDataSource.getServices();
      await localDataSource.cacheServices(services);
      return services.map((model) => model.toEntity()).toList();
    } catch (e) {
      final cached = localDataSource.getCachedServices();
      return cached.map((model) => model.toEntity()).toList();
    }
  }

  @override
  Future<Service> addService(Service service) async {
    final model = ServiceModel(
      name: service.name,
      category: service.category,
      price: service.price,
      imageUrl: service.imageUrl,
      availability: service.availability,
      duration: service.duration,
      rating: service.rating,
    );
    final result = await remoteDataSource.addService(model);
    return result.toEntity();
  }

  @override
  Future<Service> updateService(Service service) async {
    final model = ServiceModel(
      id: service.id,
      name: service.name,
      category: service.category,
      price: service.price,
      imageUrl: service.imageUrl,
      availability: service.availability,
      duration: service.duration,
      rating: service.rating,
    );
    final result = await remoteDataSource.updateService(model);
    return result.toEntity();
  }

  @override
  Future<void> deleteService(String id) async {
    await remoteDataSource.deleteService(id);
  }
}

extension on ServiceModel {
  Service toEntity() => Service(
        id: id,
        name: name,
        category: category,
        price: price,
        imageUrl: imageUrl,
        availability: availability,
        duration: duration,
        rating: rating,
      );
}
