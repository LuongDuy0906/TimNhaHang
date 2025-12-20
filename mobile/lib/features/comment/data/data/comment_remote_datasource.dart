import 'package:mobile/core/data/api/api_client.dart';
import 'package:mobile/core/data/firebase_remote_datasource.dart';
import 'package:mobile/features/comment/data/model/comment_model.dart';

abstract class CommentRemoteDatasource {
  Future<List<CommentModel>> getAllById(String restaurantId);
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
  Future<List<CommentModel>> getAllById(String restaurantId) async {
    try {
      final response = await _apiClient.get('/comments/$restaurantId');
      final List<dynamic> commentList = response as List;

      return commentList.map((json) => CommentModel.fromJson(json)).toList();
    } on NotFoundException {
      // Nếu API trả 404, trả về list rỗng
      return [];
    } catch (e) {
      // Ném các lỗi khác (ServerException, NetworkException...)
      rethrow;
    }
  }
}
