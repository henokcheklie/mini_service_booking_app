import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_service_booking_app/core/constants.dart';
import 'package:mini_service_booking_app/data/models/service_model.dart';

class ServiceRemoteDataSource {
  Future<List<ServiceModel>> getServices() async {
    final response = await http.get(Uri.parse(Constants.apiBaseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ServiceModel.fromJson(json)).toList();
    }
    throw Exception(
        'Failed to fetch services: ${response.statusCode} - ${response.body}');
  }

  Future<ServiceModel> addService(ServiceModel service) async {
    final response = await http.post(
      Uri.parse(Constants.apiBaseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(service.toJson()),
    );
    if (response.statusCode == 201) {
      return ServiceModel.fromJson(jsonDecode(response.body));
    }
    throw Exception(
        'Failed to add service: ${response.statusCode} - ${response.body}');
  }

  Future<ServiceModel> updateService(ServiceModel service) async {
    final response = await http.put(
      Uri.parse('${Constants.apiBaseUrl}/${service.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(service.toJson()),
    );
    if (response.statusCode == 200) {
      return ServiceModel.fromJson(jsonDecode(response.body));
    }
    throw Exception(
        'Failed to update service: ${response.statusCode} - ${response.body}');
  }

  Future<void> deleteService(String id) async {
    final response =
        await http.delete(Uri.parse('${Constants.apiBaseUrl}/$id'));
    if (response.statusCode != 200) {
      throw Exception(
          'Failed to delete service: ${response.statusCode} - ${response.body}');
    }
  }
}
