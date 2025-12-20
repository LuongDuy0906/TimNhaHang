import 'package:mobile/core/data/api/api_client.dart';
import 'package:mobile/core/data/firebase_remote_datasource.dart';
import 'package:mobile/features/history/data/models/bill_model.dart';

abstract class BillsRemoteDatasource {
  Future<List<BillModel>> getAll();
  Future<BillModel?> getBill(String id);
  Future<void> add(BillModel bill);
  Future<void> update(BillModel bill);
  Future<void> delete(String id);
  Future<List<BillModel>> getAllBillsByUid(String id);
}

class BillsRemoteDataSourceImpl implements BillsRemoteDatasource {
  final FirebaseRemoteDS<BillModel> _remoteSource;
  final ApiClient _apiClient;

  BillsRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient,
      _remoteSource = FirebaseRemoteDS<BillModel>(
        collectionName: 'bills',
        fromFirestore: (doc) => BillModel.fromFirestore(doc),
        toFirestore: (model) => model.toJson(),
      );

  @override
  Future<List<BillModel>> getAll() async {
    List<BillModel> bills = [];
    bills = await _remoteSource.getAll();
    return bills;
  }

  @override
  Future<BillModel?> getBill(String id) async {
    BillModel? bill = await _remoteSource.getById(id);
    return bill;
  }

  @override
  Future<void> add(BillModel bill) async {
    try {
      // Chuyển đối tượng comment thành một map JSON
      final data = bill.toJson();

      // Gọi phương thức post của apiClient
      // Giả định rằng endpoint để tạo comment mới là '/comments'
      await _apiClient.post('/booking', data: data);
    } catch (e) {
      // Ném các lỗi (ServerException, NetworkException...) để lớp Repository xử lý
      rethrow;
    }
  }

  @override
  Future<void> update(BillModel bill) async {
    await _remoteSource.update(bill.id.toString(), bill);
  }

  @override
  Future<void> delete(String id) async {
    await _remoteSource.delete(id);
  }

  @override
  Future<List<BillModel>> getAllBillsByUid(String uid) async {
    try {
      final response = await _apiClient.get('/booking/$uid');
      final List<dynamic> billList = response as List;

      return billList.map((json) => BillModel.fromJson(json)).toList();
    } on NotFoundException {
      // Nếu API trả 404, trả về list rỗng
      return [];
    } catch (e) {
      // Ném các lỗi khác (ServerException, NetworkException...)
      rethrow;
    }
  }
}
