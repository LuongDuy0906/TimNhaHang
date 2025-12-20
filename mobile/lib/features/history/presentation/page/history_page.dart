import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/data/api/api_client.dart';
import 'package:mobile/features/history/data/data/bill_remote_datasouce.dart';
import 'package:mobile/features/history/data/respositories/bill_repository_impl.dart';
import 'package:mobile/features/history/domain/entities/bill.dart';
import 'package:mobile/features/history/domain/usecase/get_bills_by_uid.dart';
import 'package:mobile/features/history/domain/usecase/get_restaurants_from_bills.dart';
import 'package:mobile/features/history/presentation/widget/list_data_history.dart';
import 'package:mobile/features/home/data/data/restaurant_remote_datasource.dart';
import 'package:mobile/features/home/data/repositories/restaurant_repository_impl.dart';
import 'package:mobile/features/home/domain/entities/restaurant.dart';
import 'package:mobile/features/home/domain/usecase/update_restaurant.dart';
import 'package:mobile/features/home/presentation/pages/detail_restaurant.dart';

class HistoryPage extends StatefulWidget {
  final String uid;
  const HistoryPage({super.key, required this.uid});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final _dio = Dio();
  late final _apiClient = ApiClient(dio: _dio);
  late final _remoteBill = BillsRemoteDataSourceImpl(apiClient: _apiClient);
  late final _repoBill = BillRepositoryImpl(_remoteBill);
  late final _getAllBillsByUid = GetAllBillsByUid(_repoBill);
  late final _remoteRestaurant = RestaurantsRemoteDataSourceImpl(
    apiClient: _apiClient,
  );
  late final _repoRestaurant = RestaurantRepositoryImpl(_remoteRestaurant);
  late final _getRestaurantsFromBill = GetRestaurantsFromBills(_repoRestaurant);
  late final _updateRestaurant = UpdateRestaurant(_repoRestaurant);
  late List<Bill> listBill;
  late List<Restaurant> listRestaurantFromBill;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final bills = await _getAllBillsByUid(widget.uid);
    final restaurants = await _getRestaurantsFromBill(bills);
    print(restaurants);
    print(bills);
    setState(() {
      listBill = bills;
      listRestaurantFromBill = restaurants;
      isLoading = false;
    });
  }

  void openDetailRestaurant(Restaurant restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailRestaurantPage(
          restaurant: restaurant,
          updateRestaurant: _updateRestaurant,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đặt bàn'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListDataHistory(
              listBill: listBill,
              listRestaurantFromBill: listRestaurantFromBill,
              openDetailRestaurant: openDetailRestaurant,
            ),
    );
  }
}
