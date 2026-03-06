import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import '../models/activity_model.dart';
import '../../../../utils/services/network_service.dart';

class ActivityRepository {
  final NetworkService _networkService = Get.find<NetworkService>();
  final storage = const FlutterSecureStorage();
  final SupabaseClient _supabase = Supabase.instance.client;

  void subscribeToActivityLogs({
    required void Function(ActivityModel newLog) onNewLog,
  }) {
    _supabase
        .channel('activity_logs_realtime')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'activity_logs',
          callback: (payload) {
            debugPrint("Realtime log received: ${payload.newRecord}");
            onNewLog(ActivityModel.fromJson(payload.newRecord));
          },
        )
        .subscribe();
  }

  Future<List<ActivityModel>> getLogs() async {
    try {
      final response = await _networkService.get(
        '/rest/v1/activity_logs?select=*&order=created_at.desc&limit=10',
      );

      if (response.statusCode == 200) {
        return List<ActivityModel>.from(
          (response.data as List).map((x) => ActivityModel.fromJson(x)),
        );
      } else {
        throw "Failed to load activity logs: ${response.statusMessage}";
      }
    } on DioException catch (e) {
      debugPrint("Error on getLogs: ${e.response?.data}");
      throw e.message ?? "An error occurred while fetching activity logs";
    }
  }

  Future<void> addLog({
    required String action,
    String? entityId,
    required Map<String, dynamic> details,
  }) async {
    try {
      final userId = await storage.read(key: 'user_id');

      await _networkService.dio.post(
        '/rest/v1/activity_logs',
        data: {
          'user_id': userId,
          'action': action,
          'entity_id': entityId,
          'details': details,
        },
        options: Options(headers: {'Prefer': 'return=representation'}),
      );
    } on DioException catch (e) {
      debugPrint("Error on addLog: ${e.response?.data}");
    }
  }
}
