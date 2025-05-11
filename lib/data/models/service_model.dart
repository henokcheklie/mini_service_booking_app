import 'package:hive/hive.dart';
part 'service_model.g.dart';

@HiveType(typeId: 0)
class ServiceModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final String imageUrl;
  @HiveField(5)
  final bool availability;
  @HiveField(6)
  final int duration;
  @HiveField(7)
  final double rating;

  ServiceModel({
    this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.availability,
    required this.duration,
    required this.rating,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        price: double.parse(json['price'].toString()),
        imageUrl: json['imageUrl'],
        availability: json['availability'],
        duration: json['duration'],
        rating: double.parse(json['rating'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'price': price,
        'imageUrl': imageUrl,
        'availability': availability,
        'duration': duration,
        'rating': rating,
      };
}
