import 'package:mobile/features/comment/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> getCommentById(String restaurantId, int size);
  Future<void> createComment(Comment comment);
}
