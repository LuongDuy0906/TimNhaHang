import 'package:mobile/core/data/api/api_client.dart';
import 'package:mobile/core/data/firebase_remote_datasource.dart';
import 'package:mobile/features/comment/data/model/comment_model.dart';

abstract class CommentRemoteDatasource {
  Future<List<CommentModel>> getAllById(String restaurantId, int size);
  Future<void> add(CommentModel comment);
}

class CommentRemoteDatasourceImpl implements CommentRemoteDatasource {
  final FirebaseRemoteDS<CommentModel> remoteDS;
  final ApiClient _apiClient;

  CommentRemoteDatasourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient,
      remoteDS = FirebaseRemoteDS<CommentModel>(
        collectionName: 'comments',
        fromFirestore: (doc) => CommentModel.fromFirestore(doc),
        toFirestore: (model) => model.toJson(),
      );

  @override
  Future<void> add(CommentModel comment) async {
    try {
      // Chuyển đối tượng comment thành một map JSON
      final data = comment.toJson();

      // Gọi phương thức post của apiClient
      // Giả định rằng endpoint để tạo comment mới là '/comments'
      await _apiClient.post('/comments', data: data);
    } catch (e) {
      // Ném các lỗi (ServerException, NetworkException...) để lớp Repository xử lý
      rethrow;
    }
  }

  @override
  Future<List<CommentModel>> getAllById(String restaurantId, int size, {int page = 0}) async {
  try {
    // 1. Thêm tham số page và size vào URL theo đúng API mới
    final response = await _apiClient.get('/comments/$restaurantId?page=$page&size=$size');

    // 2. Ép kiểu response về Map vì Spring Page trả về một Object {} không phải Array []
    final Map<String, dynamic> data = response as Map<String, dynamic>;

    // 3. Lấy danh sách từ trường 'content'
    final List<dynamic> commentList = data['content'] as List;

    return commentList.map((json) => CommentModel.fromJson(json)).toList();
  } on NotFoundException {
    return [];
  } catch (e) {
    rethrow;
  }
}
}
