import 'package:mobile/features/comment/data/data/comment_remote_datasource.dart';
import 'package:mobile/features/comment/data/model/comment_model.dart';
import 'package:mobile/features/comment/domain/entities/comment.dart';
import 'package:mobile/features/comment/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl extends CommentRepository {
  final CommentRemoteDatasource commentRemoteDatasource;

  CommentRepositoryImpl(this.commentRemoteDatasource);

  @override
  Future<void> createComment(Comment comment) async {
    CommentModel commentModel = CommentModel.fromEntity(comment);
    await commentRemoteDatasource.add(commentModel);
  }

  @override
  Future<List<Comment>> getCommentById(String restaurantId, int size) async {
    List<CommentModel> comments = await commentRemoteDatasource.getAllById(
      restaurantId, size
    );
    return comments;
  }
}
