import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../../../../utils/services/network_service.dart';
import '../models/analytics_model.dart';
import 'package:intl/intl.dart';

class AnalyticsRepository {
  final NetworkService _networkService = Get.find<NetworkService>();

  Future<QuickStats> getQuickStats() async {
    try {
      final itemsResponse = await _networkService.get(
        '/rest/v1/items?select=id',
      );
      final totalAssets = (itemsResponse.data as List).length;

      final loansResponse = await _networkService.get(
        '/rest/v1/loans?return_date=is.null&select=id',
      );
      final activeLoans = (loansResponse.data as List).length;

      final now = DateTime.now().toIso8601String();
      final overdueResponse = await _networkService.get(
        '/rest/v1/loans?return_date=is.null&due_date=lt.$now&select=id',
      );
      final overdueCount = (overdueResponse.data as List).length;

      final utilizationRate = totalAssets > 0
          ? (activeLoans / totalAssets) * 100
          : 0.0;

      return QuickStats(
        totalAssets: totalAssets,
        activeLoans: activeLoans,
        utilizationRate: utilizationRate,
        overdueCount: overdueCount,
      );
    } on dio.DioException catch (e) {
      throw e.message ?? "Error fetching quick stats";
    }
  }

  Future<List<CategoryData>> getCategoryDistribution() async {
    try {
      final response = await _networkService.get(
        '/rest/v1/items?select=category',
      );
      final List data = response.data;

      final Map<String, int> counts = {};
      for (var item in data) {
        final category = item['category'] ?? 'Uncategorized';
        counts[category] = (counts[category] ?? 0) + 1;
      }

      return counts.entries
          .map((e) => CategoryData(category: e.key, count: e.value))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<TopItemData>> getTopBorrowedItems() async {
    try {
      // This is a simplified approach fetching all loans and counting
      // In production, an RPC or better DB query would be preferred
      final response = await _networkService.get(
        '/rest/v1/loans?select=item_id,items(name)',
      );
      final List data = response.data;

      final Map<String, int> counts = {};
      final Map<String, String> names = {};

      for (var loan in data) {
        final itemId = loan['item_id'].toString();
        final itemName = loan['items']?['name'] ?? 'Unknown Item';
        counts[itemId] = (counts[itemId] ?? 0) + 1;
        names[itemId] = itemName;
      }

      final sorted = counts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      return sorted
          .take(5)
          .map(
            (e) => TopItemData(itemName: names[e.key]!, borrowCount: e.value),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<OverdueData>> getOverdueTrend() async {
    try {
      final now = DateTime.now().toIso8601String();
      final response = await _networkService.get(
        '/rest/v1/loans?return_date=is.null&due_date=lt.$now&select=due_date',
      );
      final List data = response.data;

      final Map<String, int> trend = {};
      final DateFormat formatter = DateFormat('yyyy-MM-dd');

      for (var loan in data) {
        final date = formatter.format(DateTime.parse(loan['due_date']));
        trend[date] = (trend[date] ?? 0) + 1;
      }

      return trend.entries
          .map((e) => OverdueData(date: DateTime.parse(e.key), count: e.value))
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date));
    } catch (e) {
      return [];
    }
  }
}
