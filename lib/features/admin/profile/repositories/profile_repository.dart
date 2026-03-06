import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../../../utils/services/network_service.dart';
import '../../../auth/setup_profile/models/profile_model.dart';

class ProfileRepository {
  final NetworkService _networkService = Get.find<NetworkService>();
  final storage = const FlutterSecureStorage();

  Future<ProfileModel?> getProfile() async {
    try {
      final userId = await storage.read(key: 'user_id');
      if (userId == null) return null;

      final response = await _networkService.get(
        '/rest/v1/profiles?id=eq.$userId&select=*',
      );

      if (response.statusCode == 200 && (response.data as List).isNotEmpty) {
        return ProfileModel.fromJson(response.data[0]);
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching profile: $e");
      return null;
    }
  }
}
