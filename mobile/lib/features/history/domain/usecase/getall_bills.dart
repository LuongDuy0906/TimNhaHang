import 'package:mobile/features/history/domain/entities/bill.dart';
import 'package:mobile/features/history/domain/respositories/bill_respository.dart';

class GetAllBills {
  final BillReposiitory repository;
  GetAllBills(this.repository);
  Future<List<Bill>> call() => repository.getBills();
}
