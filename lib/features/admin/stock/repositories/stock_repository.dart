import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../models/stock_model.dart';
import '../models/loan_model.dart';
import '../../../../utils/services/network_service.dart';

class StockRepository {
  final NetworkService _networkService = Get.find<NetworkService>();

  Future<List<StockModel>> getItems() async {
    try {
      final response = await _networkService.post(
        '/rest/v1/rpc/get_items_with_stock',
        data: {},
      );

      if (response.statusCode == 200) {
        return List<StockModel>.from(
          response.data.map((x) => StockModel.fromJson(x)),
        );
      } else {
        throw "Failed to load items: ${response.statusMessage}";
      }
    } on DioException catch (e) {
      throw e.message ?? "An error occurred while fetching items";
    }
  }

  Future<void> addItem({
    required String name,
    required String category,
    required int stock,
  }) async {
    try {
      await _networkService.dio.post(
        '/rest/v1/items',
        data: {
          'name': name,
          'category': category,
          'total_stock': stock,
          'available_stock': stock,
        },
        options: Options(headers: {'Prefer': 'return=representation'}),
      );
    } on DioException catch (e) {
      debugPrint("Error on addItem: ${e.response?.data}");
      throw e.message ?? "An error occurred while adding item";
    }
  }

  Future<void> updateItem({
    required String id,
    required String name,
    required String category,
    required int stock,
  }) async {
    try {
      await _networkService.dio.patch(
        '/rest/v1/items?id=eq.$id',
        data: {
          'name': name,
          'category': category,
          'total_stock': stock,
          'available_stock': stock,
        },
        options: Options(headers: {'Prefer': 'return=representation'}),
      );
    } on DioException catch (e) {
      debugPrint("Error on updateItem: ${e.response?.data}");
      throw e.message ?? "An error occurred while updating item";
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _networkService.delete('/rest/v1/items?id=eq.$id');
    } on DioException catch (e) {
      debugPrint("Error on deleteItem: ${e.response?.data}");
      throw e.message ?? "An error occurred while deleting item";
    }
  }

  Future<List<LoanModel>> getLoans() async {
    try {
      final response = await _networkService.get('/rest/v1/loans?select=*');

      if (response.statusCode == 200) {
        return List<LoanModel>.from(
          response.data.map((x) => LoanModel.fromJson(x)),
        );
      } else {
        throw "Failed to load loans: ${response.statusMessage}";
      }
    } on DioException catch (e) {
      throw e.message ?? "An error occurred while fetching loans";
    }
  }

  Future<int> getAvailableStock({
    required String itemId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await _networkService.post(
        '/rest/v1/rpc/get_available_stock',
        data: {
          'p_item_id': itemId,
          'p_start_date': startDate,
          'p_end_date': endDate,
        },
      );

      return response.data as int;
    } on DioException catch (e) {
      debugPrint("Error on getAvailableStock: ${e.response?.data}");
      throw e.message ?? "An error occurred while checking stock";
    }
  }

  Future<void> borrowItem({
    required String itemId,
    required String borrowerName,
    required String loanDate,
    required String dueDate,
  }) async {
    try {
      await _networkService.post(
        '/rest/v1/rpc/borrow_item',
        data: {
          'p_item_id': itemId,
          'p_borrower_name': borrowerName,
          'p_loan_date': loanDate,
          'p_due_date': dueDate,
        },
      );
    } on DioException catch (e) {
      debugPrint("Error on borrowItem: ${e.response?.data}");
      throw e.message ?? "An error occurred while borrowing item";
    }
  }

  Future<void> returnItem(String loanId) async {
    try {
      await _networkService.post(
        '/rest/v1/rpc/return_item',
        data: {'p_loan_id': loanId},
      );
    } on DioException catch (e) {
      debugPrint("Error on returnItem: ${e.response?.data}");
      throw e.message ?? "An error occurred while returning item";
    }
  }

  Future<StockModel> getItemById(String id) async {
    try {
      final response = await _networkService.get(
        '/rest/v1/items?id=eq.$id&select=*',
      );

      if (response.statusCode == 200 && (response.data as List).isNotEmpty) {
        return StockModel.fromJson(response.data[0]);
      } else {
        throw "Item not found";
      }
    } on DioException catch (e) {
      debugPrint("Error on getItemById: ${e.response?.data}");
      throw e.message ?? "An error occurred while fetching item detail";
    }
  }
}
