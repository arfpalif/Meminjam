import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../../../../utils/services/network_service.dart';

class HomeRepository {
  final NetworkService _networkService = Get.find<NetworkService>();

  Future<dio.Response> getItems() async {
    try {
      final response = await _networkService.get('/rest/v1/items?select=*');
      return response;
    } on dio.DioException catch (e) {
      throw e.message ?? "An error occurred while fetching home items";
    }
  }
}
