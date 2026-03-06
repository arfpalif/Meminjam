import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../../../../utils/services/network_service.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  final NetworkService _networkService = Get.find<NetworkService>();

  Future<dio.Response> createProfile(ProfileModel profile, String token) async {
    try {
      // If token is provided directly, we can use it in headers specifically for this request
      final response = await _networkService.dio.post(
        '/rest/v1/profiles',
        data: profile.toJson(),
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Prefer': 'return=representation',
          },
        ),
      );
      return response;
    } on dio.DioException catch (e) {
      throw e.message ?? "An error occurred during profile creation";
    }
  }
}
