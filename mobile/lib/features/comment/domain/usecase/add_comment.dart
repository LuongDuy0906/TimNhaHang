import 'package:mobile/features/comment/domain/entities/comment.dart';
import 'package:mobile/features/comment/domain/repositories/comment_repository.dart';

class AddComment {
  final CommentRepository commentRepository;

  AddComment(this.commentRepository);

  Future<void> call(Comment comment) {
    return commentRepository.createComment(comment);
  }
}
