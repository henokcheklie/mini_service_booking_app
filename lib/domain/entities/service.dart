class Service {
  final String? id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final bool availability;
  final int duration;
  final double rating;

  Service({
    this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.availability,
    required this.duration,
    required this.rating,
  });

  Service copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    String? imageUrl,
    bool? availability,
    int? duration,
    double? rating,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      availability: availability ?? this.availability,
      duration: duration ?? this.duration,
      rating: rating ?? this.rating,
    );
  }
}
