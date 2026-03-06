import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/services/network_service.dart';
import '../../../../env/env.dart';

class RegisterRepository {
  final NetworkService _networkService = Get.find<NetworkService>();

  Future<dio.Response> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _networkService.dio.post(
        '/auth/v1/signup',
        data: {'email': email, 'password': password},
        options: dio.Options(
          headers: {'Authorization': 'Bearer ${Env.supabaseAnonKey}'},
        ),
      );
      return response;
    } on dio.DioException catch (e) {
      debugPrint("Error on signup: ${e.response?.data}");
      throw e.message ?? "An error occurred during signup";
    }
  }
}
