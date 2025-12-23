import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/data/api/api_client.dart';
import 'package:mobile/features/comment/data/data/comment_remote_datasource.dart';
import 'package:mobile/features/comment/data/repositories/comment_repository_impl.dart';
import 'package:mobile/features/comment/domain/entities/comment.dart';
import 'package:mobile/features/comment/domain/usecase/get_all_comment.dart';

class CommentSection extends StatefulWidget {
  final String restaurantId;

  const CommentSection({super.key, required this.restaurantId});

  @override
  State<StatefulWidget> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  // 1. Khởi tạo các dependencies
  late final _dio = Dio();
  late final _apiClient = ApiClient(dio: _dio);
  late final _remote = CommentRemoteDatasourceImpl(apiClient: _apiClient);
  late final _repo = CommentRepositoryImpl(_remote);
  late final _getComment = GetAllComment(_repo);

  // 2. Các biến quản lý trạng thái
  List<Comment>? _comments; 
  int _currentSize = 2;     // Size khởi đầu
  bool _isLoading = false;  // Trạng thái đang gọi API
  bool _hasMore = true;     // Còn dữ liệu để xem thêm không

  @override
  void initState() {
    super.initState();
    _fetchComments(); // Tải 2 bình luận đầu tiên ngay khi vào trang
  }

  // Hàm gọi API
  Future<void> _fetchComments() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      // Gọi usecase với size hiện tại
      final results = await _getComment(widget.restaurantId, size: _currentSize);

      setState(() {
        _comments = results;
        
        // Nếu server trả về ít hơn số lượng mình yêu cầu, nghĩa là đã hết bình luận
        if (results.length < _currentSize) {
          _hasMore = false;
        } else {
          _hasMore = true;
        }
      });
    } catch (e) {
      debugPrint("Lỗi tải bình luận: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Xử lý khi bấm nút "Xem thêm"
  void _onSeeMorePressed() {
    setState(() {
      _currentSize += 2; // Tăng size lên 2
    });
    _fetchComments(); // Gọi lại API để lấy danh sách mới dài hơn
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF42A5F5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ĐÁNH GIÁ & BÌNH LUẬN',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const Divider(height: 20),

        // 3. Hiển thị danh sách bình luận (Thay cho FutureBuilder)
        _buildListContent(),

        const SizedBox(height: 10),

        // 4. Nút Xem thêm / Xem tất cả
        if (_hasMore)
          Center(
            child: _isLoading && _comments != null
                ? const SizedBox(
                    width: 20, 
                    height: 20, 
                    child: CircularProgressIndicator(strokeWidth: 2)
                  )
                : TextButton(
                    onPressed: _onSeeMorePressed,
                    child: const Text(
                      'Xem thêm bình luận',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
      ],
    );
  }

  // Widget hiển thị nội dung chính
  Widget _buildListContent() {
    if (_comments == null && _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_comments == null || _comments!.isEmpty) {
      return const Center(
        child: Text('Chưa có bình luận nào.', style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _comments!.length,
      itemBuilder: (context, index) {
        return _buildCommentItem(_comments![index]);
      },
    );
  }

  // --- Giữ nguyên các hàm bổ trợ UI của bạn ---

  Widget _buildCommentItem(Comment comment) {
    final String date = "${comment.createdAt.day}/${comment.createdAt.month}/${comment.createdAt.year}";

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: comment.userImage.isNotEmpty ? NetworkImage(comment.userImage) : null,
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            child: comment.userImage.isEmpty
                ? Text(comment.userName.isNotEmpty ? comment.userName[0].toUpperCase() : 'A')
                : null,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comment.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ..._buildStars(comment.rating),
                    const SizedBox(width: 8),
                    Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(comment.content),
                _buildCommentImage(comment.imageUrl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(const Icon(Icons.star, color: Colors.amber, size: 16));
      } else {
        stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 16));
      }
    }
    return stars;
  }

  Widget _buildCommentImage(String imageUrl) {
    if (imageUrl.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(imageUrl, height: 150, width: 250, fit: BoxFit.cover),
      ),
    );
  }
}