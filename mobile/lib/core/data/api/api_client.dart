import 'package:dio/dio.dart';

// --- 1. Định nghĩa các Exception tùy chỉnh ---
// (Bạn nên tạo 1 file riêng, ví dụ: core/error/exceptions.dart)
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class UnauthorizedException implements Exception {
  // Không cần message vì lý do đã rõ
}

class NotFoundException implements Exception {}

// --- 2. Lớp ApiClient ---
class ApiClient {
  final Dio dio;

  ApiClient({required this.dio}) {
    // --- 3. Cấu hình Dio tập trung ---
    dio.options.baseUrl = 'http://10.0.2.2:8080/api'; // <-- URL gốc của bạn
    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.receiveTimeout = Duration(seconds: 10);
    dio.options.headers['Content-Type'] = 'application/json';

    // --- 4. Thêm Interceptors ---
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    // Thêm interceptor để tự động thêm token (ví dụ)
    // dio.interceptors.add(_createAuthInterceptor());
  }

  // --- 5. Phương thức GET chung ---
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParams);
      return response.data; // Trả về dữ liệu đã được parse (dynamic)
    } on DioException catch (e) {
      // --- 6. Xử lý lỗi tập trung ---
      throw _handleError(e);
    } catch (e) {
      throw ServerException("Lỗi không xác định: ${e.toString()}");
    }
  }

  // --- 7. Phương thức POST chung ---
  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw ServerException("Lỗi không xác định: ${e.toString()}");
    }
  }

  // (Tương tự cho PUT, DELETE...)

  // --- 8. Hàm "dịch" lỗi ---
  Exception _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException("Không có kết nối mạng hoặc hết thời gian chờ.");
    }

    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 401:
          return UnauthorizedException();
        case 404:
          return NotFoundException();
        case 500:
        default:
          return ServerException("Lỗi máy chủ: ${e.response!.statusCode}");
      }
    }

    return ServerException("Lỗi Dio không xác định.");
  }

  // (Ví dụ về Auth Interceptor)
  // Interceptor _createAuthInterceptor() {
  //   return InterceptorsWrapper(
  //     onRequest: (options, handler) async {
  //       // Lấy token từ đâu đó (ví dụ: SharedPreferences)
  //       final String? token = await secureStorage.read('token');
  //       if (token != null) {
  //         options.headers['Authorization'] = 'Bearer $token';
  //       }
  //       return handler.next(options); // Tiếp tục request
  //     },
  //     onError: (DioException e, handler) async {
  //       // Xử lý logic refresh token nếu bị 401
  //       if (e.response?.statusCode == 401) {
  //         // ... logic refresh token ...
  //       }
  //       return handler.next(e);
  //     }
  //   );
  // }
}
