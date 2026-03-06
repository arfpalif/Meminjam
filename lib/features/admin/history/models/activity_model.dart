import 'dart:convert';

class ActivityModel {
  final String id;
  final String? userId;
  final String action;
  final String? entityId;
  final Map<String, dynamic> details;
  final DateTime createdAt;

  ActivityModel({
    required this.id,
    this.userId,
    required this.action,
    this.entityId,
    required this.details,
    required this.createdAt,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
    id: json["id"],
    userId: json["user_id"],
    action: json["action"],
    entityId: json["entity_id"],
    details: json["details"] is String
        ? jsonDecode(json["details"])
        : json["details"] ?? {},
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "action": action,
    "entity_id": entityId,
    "details": details,
    "created_at": createdAt.toIso8601String(),
  };
}
