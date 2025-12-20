import 'package:mobile/core/data/firebase_remote_datasource.dart';
import 'package:mobile/features/home/data/models/restaurant_model.dart';
import 'package:mobile/core/data/api/api_client.dart';

abstract class RestaurantRemoteDatasource {
  Future<List<RestaurantModel>> getAll();
  Future<RestaurantModel?> getRestaurant(String id);
  Future<void> update(RestaurantModel restaurant);
  Future<List<RestaurantModel>> search(String text);
} // <-- 1. Import ApiClient

class RestaurantsRemoteDataSourceImpl implements RestaurantRemoteDatasource {
  // --- 3. THAY ĐỔI: Khai báo CẢ HAI nguồn dữ liệu ---
  final FirebaseRemoteDS<RestaurantModel> _firebaseRemoteDS;
  final ApiClient _apiClient;

  RestaurantsRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient, // Nhận ApiClient từ bên ngoài
      _firebaseRemoteDS = FirebaseRemoteDS<RestaurantModel>(
        // Vẫn tự khởi tạo
        collectionName: 'restaurant',
        fromFirestore: (doc) => RestaurantModel.fromFirestore(doc),
        toFirestore: (model) => model.toJson(),
      );

  // --- 5. THAY ĐỔI: Phương thức này dùng API ---
  @override
  Future<List<RestaurantModel>> getAll() async {
    try {
      // Giả sử endpoint lấy tất cả nhà hàng là '/restaurants'
      final responseData = await _apiClient.get('/restaurants');

      // Giả sử API trả về một list JSON, ví dụ: [ {..}, {..} ]
      // Nếu API trả về dạng { "data": [ ... ] }
      // thì bạn dùng: final List<dynamic> restaurantList = responseData['data'] as List;
      final List<dynamic> restaurantList = responseData as List;

      // Bạn BẮT BUỘC phải có factory RestaurantModel.fromJson
      return restaurantList
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    } on NotFoundException {
      // Nếu API trả 404, trả về list rỗng
      return [];
    } catch (e) {
      // Ném các lỗi khác (ServerException, NetworkException...)
      rethrow;
    }
  }

  @override
  Future<RestaurantModel?> getRestaurant(String id) async {
    try {
      // 1. Giả sử endpoint lấy nhà hàng theo ID là '/restaurants/{id}'
      final responseData = await _apiClient.get('/restaurants/$id');

      // 2. Giả sử API trả về một đối tượng JSON duy nhất { ... }
      final Map<String, dynamic> restaurantJson =
          responseData as Map<String, dynamic>;

      // 3. Chuyển đổi JSON thành RestaurantModel và trả về
      return RestaurantModel.fromJson(restaurantJson);
    } on NotFoundException {
      // Nếu API trả về 404 (Không tìm thấy nhà hàng), trả về null
      return null;
    } catch (e) {
      // Ném các lỗi khác (NetworkException, ServerException, v.v.)
      rethrow;
    }
  }

  @override
  Future<void> update(RestaurantModel restaurant) async {
    await _firebaseRemoteDS.update(restaurant.id.toString(), restaurant);
  }

  @override
  Future<List<RestaurantModel>> search(String text) async {
    // 1. Mã hóa (encode) văn bản tìm kiếm để đảm bảo nó hợp lệ khi đưa vào URL
    final String encodedText = Uri.encodeComponent(text);
    // Ví dụ 3 (Dựa theo code Firebase cũ): /restaurants?name=searchText
    final String endpoint = '/restaurants?name=$encodedText';

    try {
      // 3. Gọi API với endpoint đã xây dựng
      final responseData = await _apiClient.get(endpoint);

      // 4. Xử lý dữ liệu trả về (giống hệt getAll)
      // Nếu API trả về dạng { "data": [ ... ] }
      // final List<dynamic> restaurantList = responseData['data'] as List;
      final List<dynamic> restaurantList = responseData as List;

      // 5. Chuyển đổi list JSON thành list RestaurantModel
      return restaurantList
          .map((json) => RestaurantModel.fromJson(json))
          .toList();
    } on NotFoundException {
      // 6. Nếu API trả 404 (Không tìm thấy), trả về list rỗng
      return [];
    } catch (e) {
      // 7. Ném các lỗi khác (ServerException, NetworkException...)
      rethrow;
    }
  }
}
