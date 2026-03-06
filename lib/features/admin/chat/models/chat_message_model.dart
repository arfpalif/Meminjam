class ChatMessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime createdAt;

  ChatMessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatMessageModel(
        id: json['id'],
        chatId: json['chat_id'],
        senderId: json['sender_id'],
        content: json['content'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'chat_id': chatId,
    'sender_id': senderId,
    'content': content,
    'created_at': createdAt.toIso8601String(),
  };
}
