import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../../../utils/services/network_service.dart';
import '../../setup_profile/models/profile_model.dart';
import '../../../../env/env.dart';

class LoginRepository {
  final NetworkService _networkService = Get.find<NetworkService>();
  final storage = const FlutterSecureStorage();

  Future<dio.Response> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _networkService.dio.post(
        '/auth/v1/token?grant_type=password',
        data: {'email': email, 'password': password},
        options: dio.Options(
          headers: {'Authorization': 'Bearer ${Env.supabaseAnonKey}'},
        ),
      );

      await storage.write(key: 'token', value: response.data['access_token']);
      await storage.write(key: 'user_id', value: response.data['user']['id']);
      return response;
    } on dio.DioException catch (e) {
      debugPrint("Error on login: ${e.response?.data}");
      throw e.message ?? "An error occurred during login";
    }
  }

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
