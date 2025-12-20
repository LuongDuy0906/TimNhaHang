import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/home/domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required super.id,
    required super.address,
    required super.category,
    required super.closing,
    required super.imageUrl,
    required super.name,
    required super.opening,
    required super.priceRange,
    required super.rating,
    required super.saved,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      // Giả sử API trả về 'id' bên trong JSON
      id: (json['id']).toString(),
      address: json['address'] ?? '',
      category: json['category'] ?? '',
      closing: json['closing'] ?? '',
      imageUrl: json['image_url'] ?? '',
      name: json['name'] ?? '',
      opening: json['opening'] ?? '',
      priceRange: json['price_range'] ?? '',
      // Thêm .toDouble() để đảm bảo kiểu dữ liệu
      rating: (json['rating'] ?? 0).toDouble(),
      saved: json['saved'] ?? false,
    );
  }

  factory RestaurantModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RestaurantModel(
      id: doc.id,
      address: data['address'] ?? '',
      category: data['category'] ?? '',
      closing: data['closing'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      name: data['name'] ?? '',
      opening: data['opening'] ?? '',
      priceRange: data['priceRange'] ?? '',
      rating: data['rating'] ?? 0,
      saved: data['saved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'address': address,
    'category': category,
    'closing': closing,
    'imageUrl': imageUrl,
    'name': name,
    'opening': opening,
    'priceRange': priceRange,
    'rating': rating,
    'saved': saved,
  };
  factory RestaurantModel.fromEntity(Restaurant e) => RestaurantModel(
    id: e.id,
    address: e.address,
    category: e.category,
    closing: e.closing,
    imageUrl: e.imageUrl,
    name: e.name,
    opening: e.opening,
    priceRange: e.priceRange,
    rating: e.rating,
    saved: e.saved,
  );
}
