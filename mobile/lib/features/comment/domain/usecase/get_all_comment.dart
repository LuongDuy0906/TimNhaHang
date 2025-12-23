import 'package:mobile/features/comment/domain/entities/comment.dart';
import 'package:mobile/features/comment/domain/repositories/comment_repository.dart';

class GetAllComment {
  final CommentRepository commentRepository;

  GetAllComment(this.commentRepository);

  Future<List<Comment>> call(String restaurantId, {int size = 2}) {
    return commentRepository.getCommentById(restaurantId, size);
  }
}
