import 'package:mobile/features/home/domain/entities/restaurant.dart';
import 'package:mobile/features/home/domain/repositories/restaurant_repository.dart';

class UpdateRestaurant {
  final RestaurantRepository repository;

  UpdateRestaurant(this.repository);

  Future<void> call(Restaurant restaurant) async {
    await repository.updateNote(restaurant);
  }
}
