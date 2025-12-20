import 'package:mobile/features/home/domain/entities/restaurant.dart';
import 'package:mobile/features/home/domain/repositories/restaurant_repository.dart';

class GetRestaurant {
  final RestaurantRepository repository;
  GetRestaurant(this.repository);
  Future<Restaurant?> call(String id) => repository.getRestaurant(id);
}
