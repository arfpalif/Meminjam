import 'package:get/get.dart';
import '../models/analytics_model.dart';
import '../repositories/analytics_repository.dart';

class AnalyticsController extends GetxController {
  final AnalyticsRepository _repository = Get.find<AnalyticsRepository>();

  final Rx<AnalyticsModel?> analyticsData = Rx<AnalyticsModel?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final quickStats = await _repository.getQuickStats();
      final categoryData = await _repository.getCategoryDistribution();
      final topBorrowedItems = await _repository.getTopBorrowedItems();
      final overdueTrend = await _repository.getOverdueTrend();

      analyticsData.value = AnalyticsModel(
        quickStats: quickStats,
        categoryData: categoryData,
        topBorrowedItems: topBorrowedItems,
        overdueTrend: overdueTrend,
      );
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
