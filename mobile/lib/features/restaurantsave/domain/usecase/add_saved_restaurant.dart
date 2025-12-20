import 'package:mobile/features/restaurantsave/domain/entities/save.dart';
import 'package:mobile/features/restaurantsave/domain/repositories/restaurant_save_repository.dart';

class AddSavedRestaurant {
  final RestaurantSaveRepository saveRepository;

  AddSavedRestaurant(this.saveRepository);

  Future<void> call(Save save) {
    return saveRepository.addSave(save);
  }
}
