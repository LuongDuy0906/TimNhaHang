import 'package:mobile/features/home/domain/entities/restaurant.dart';
import 'package:mobile/features/home/domain/repositories/restaurant_repository.dart';

class SearchRestaurant {
  final RestaurantRepository restaurantRepository;

  SearchRestaurant(this.restaurantRepository);

  Future<List<Restaurant>> call(String text) {
    return restaurantRepository.searchRestaurant(text);
  }
}
