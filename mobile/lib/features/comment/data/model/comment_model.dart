import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/comment/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.id,
    required super.restaurantId,
    required super.uid,
    required super.userImage,
    required super.userName,
    required super.rating,
    required super.content,
    required super.imageUrl,
    required super.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    // Trích xuất ID nhà hàng từ đối tượng lồng nhau 'restaurants'
    final restaurantData = json['restaurants'] as Map<String, dynamic>?;

    // Xử lý thời gian (Giả định nó là String ISO 8601 từ Spring)
    final createdAtString = json['createdAt'] as String?;

    return CommentModel(
      // ID: Khớp với 'id' và chuyển sang String
      id: (json['id'] ?? 0).toString(),

      // SỬA: Lấy restaurantId từ đối tượng con 'restaurants'
      restaurantId: restaurantData != null
          ? (restaurantData['id'] ?? '').toString()
          : '',

      // SỬA: Dùng key 'uid' (camelCase)
      uid: json['uid'] ?? '',

      // Đã khớp:
      userName: json['userName'] ?? '',
      userImage: json['userImage'] ?? '',
      content: json['content'] ?? '',

      // SỬA: Dùng key 'imageUrl' (camelCase)
      imageUrl: json['imageUrl'] ?? '',

      // SỬA: Dùng key 'createdAt' (camelCase) và Parse
      createdAt: createdAtString != null
          ? DateTime.parse(createdAtString)
          : DateTime.now(),

      // Rating: Lấy giá trị rating
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  factory CommentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CommentModel(
      id: doc.id,
      restaurantId: data['restaurantId'] ?? '',
      uid: data['uid'] ?? '',
      userName: data['userName'] ?? '',
      content: data['content'] ?? '',
      userImage: data['userImage'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      rating: (data['rating'] ?? 0 as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'restaurantId': restaurantId,
    'userName': userName,
    'content': content,
    'userImage': userImage,
    'imageUrl': imageUrl,
    'rating': rating,
    'createdAt': createdAt.toIso8601String(),
  };

  factory CommentModel.fromEntity(Comment e) => CommentModel(
    id: e.id,
    uid: e.uid,
    restaurantId: e.restaurantId,
    content: e.content,
    userName: e.userName,
    userImage: e.userImage,
    imageUrl: e.imageUrl,
    createdAt: e.createdAt,
    rating: e.rating,
  );
}
