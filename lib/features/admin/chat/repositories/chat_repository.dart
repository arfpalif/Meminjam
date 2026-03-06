import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as auth;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../models/chat_message_model.dart';
import '../../../../utils/services/network_service.dart';

class ChatRepository {
  final NetworkService _networkService = Get.find<NetworkService>();
  final storage = const FlutterSecureStorage();
  final _supabase = auth.Supabase.instance.client;

  void subscribeToMessages({
    required String chatId,
    required void Function(ChatMessageModel newMessage) onNewMessage,
  }) {
    _supabase
        .channel('public:messages:$chatId')
        .onPostgresChanges(
          event: auth.PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          filter: auth.PostgresChangeFilter(
            type: auth.PostgresChangeFilterType.eq,
            column: 'chat_id',
            value: chatId,
          ),
          callback: (payload) {
            onNewMessage(ChatMessageModel.fromJson(payload.newRecord));
          },
        )
        .subscribe();
  }

  Future<String> getOrCreateChat(String id) async {
    try {
      final response = await _networkService.get('/rest/v1/chats?id=eq.$id');

      final List data = response.data;
      if (data.isNotEmpty) {
        return data[0]['id'];
      }

      final createResponse = await _networkService.dio.post(
        '/rest/v1/chats',
        data: {'id': id},
        options: Options(headers: {'Prefer': 'return=representation'}),
      );

      return createResponse.data[0]['id'];
    } on DioException catch (e) {
      debugPrint("Error on getOrCreateChat: ${e.response?.data}");
      throw e.message ?? "An error occurred while getting/creating chat";
    }
  }

  Future<String> findOrCreateItemChat(String itemId) async {
    try {
      final response = await _networkService.get(
        '/rest/v1/chats?item_id=eq.$itemId',
      );

      final List data = response.data;
      if (data.isNotEmpty) {
        return data[0]['id'];
      }

      final createResponse = await _networkService.dio.post(
        '/rest/v1/chats',
        data: {'item_id': itemId},
        options: Options(headers: {'Prefer': 'return=representation'}),
      );

      return createResponse.data[0]['id'];
    } on DioException catch (e) {
      debugPrint("Error on findOrCreateItemChat: ${e.response?.data}");
      throw e.message ?? "An error occurred while finding/creating item chat";
    }
  }

  Future<void> sendMessage({
    required String chatId,
    required String message,
  }) async {
    try {
      final userId = await storage.read(key: 'user_id');
      if (userId == null) throw "User not authenticated";

      await _networkService.post(
        '/rest/v1/messages',
        data: {'chat_id': chatId, 'sender_id': userId, 'content': message},
      );
    } on DioException catch (e) {
      debugPrint("Error on sendMessage: ${e.response?.data}");
      throw e.message ?? "An error occurred while sending message";
    }
  }

  Future<List<ChatMessageModel>> getMessages(String chatId) async {
    try {
      final response = await _networkService.get(
        '/rest/v1/messages?chat_id=eq.$chatId&order=created_at.desc',
      );

      if (response.statusCode == 200) {
        return List<ChatMessageModel>.from(
          response.data.map((x) => ChatMessageModel.fromJson(x)),
        );
      } else {
        throw "Failed to load messages: ${response.statusMessage}";
      }
    } on DioException catch (e) {
      debugPrint("Error on getMessages: ${e.response?.data}");
      throw e.message ?? "An error occurred while fetching messages";
    }
  }

  Future<List<Map<String, dynamic>>> getChats() async {
    try {
      final response = await _networkService.get(
        '/rest/v1/chats?select=*&order=created_at.desc',
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw "Failed to load chats: ${response.statusMessage}";
      }
    } on DioException catch (e) {
      debugPrint("Error on getChats: ${e.response?.data}");
      throw e.message ?? "An error occurred while fetching chats";
    }
  }

  Future<Map<String, dynamic>> getChatById(String id) async {
    try {
      final response = await _networkService.get(
        '/rest/v1/chats?id=eq.$id&select=*',
      );

      if (response.statusCode == 200 && (response.data as List).isNotEmpty) {
        return response.data[0];
      } else {
        throw "Chat not found";
      }
    } on DioException catch (e) {
      debugPrint("Error on getChatById: ${e.response?.data}");
      throw e.message ?? "An error occurred while fetching chat detail";
    }
  }
}
