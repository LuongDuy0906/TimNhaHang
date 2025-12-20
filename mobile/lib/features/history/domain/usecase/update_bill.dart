import 'package:mobile/features/history/domain/entities/bill.dart';
import 'package:mobile/features/history/domain/respositories/bill_respository.dart';

class UpdateBill {
  final BillReposiitory repository;
  UpdateBill(this.repository);
  Future<void> call(Bill bill) async {
    repository.updateBill(bill);
  }
}
