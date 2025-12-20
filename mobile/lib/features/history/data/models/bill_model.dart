import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/history/domain/entities/bill.dart';

class BillModel extends Bill {
  const BillModel({
    required super.id,
    required super.uid,
    required super.resid,
    required super.createdAt,
    required super.bookingTime,
  });

  factory BillModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BillModel(
      id: doc.id,
      uid: data['uid'] ?? '',
      resid: data['resid'] ?? '',
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      bookingTime:
          (data['bookingTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      // ✅ 1. ID: Spring DTO không có 'id', nhưng nó cần thiết cho Flutter Model.
      // Nếu bạn muốn Flutter model có ID, DTO/Controller Spring cần trả về 'id'.
      // Nếu không có, bạn có thể gán ID là rỗng:
      id: (json['id'] ?? '').toString(), // Giả định Spring DTO trả về 'id'
      // ✅ 2. resid: Lấy ID nhà hàng từ object 'restaurantGetDTO'
      // Lưu ý: DTO Spring sử dụng key 'restaurantGetDTO'
      resid: json['restaurantGetDTO'] != null
          ? json['restaurantGetDTO']['id']
                .toString() // Lấy ID từ DTO con
          : '',

      // ✅ 3. uid: Khớp với key 'uid' của DTO Spring
      uid: json['uid'] ?? '',

      // ✅ 4. bookingTime & createdAt: Khớp với key và parse từ String ISO 8601
      bookingTime: json['bookingTime'] != null
          ? DateTime.parse(json['bookingTime'] as String)
          : DateTime.now(),

      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'restaurantId': resid,
    'createdAt': createdAt.toIso8601String(),
    'bookingTime': bookingTime.toUtc().toIso8601String(),
  };

  factory BillModel.fromEntity(Bill e) => BillModel(
    id: e.id,
    uid: e.uid,
    resid: e.resid,
    createdAt: e.createdAt,
    bookingTime: e.bookingTime,
  );
}
