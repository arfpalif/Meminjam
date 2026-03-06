import 'package:get/get.dart';
import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

class ActivityController extends GetxController {
  final ActivityRepository _repository = ActivityRepository();

  final RxList<ActivityModel> logs = <ActivityModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLogs();
    _subscribeToRealtimeLogs();
  }

  void _subscribeToRealtimeLogs() {
    _repository.subscribeToActivityLogs(
      onNewLog: (newLog) {
        logs.insert(0, newLog);
        if (logs.length > 10) {
          logs.removeLast();
        }
      },
    );
  }

  Future<void> fetchLogs() async {
    isLoading.value = true;
    try {
      final result = await _repository.getLogs();
      logs.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch activity logs');
    } finally {
      isLoading.value = false;
    }
  }
}
