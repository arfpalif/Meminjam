import 'dart:convert';

List<StockModel> stockModelFromJson(String str) =>
    List<StockModel>.from(json.decode(str).map((x) => StockModel.fromJson(x)));

String stockModelToJson(List<StockModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockModel {
  String id;
  String name;
  String category;
  int totalStock;
  int availableStock;
  DateTime createdAt;

  StockModel({
    required this.id,
    required this.name,
    required this.category,
    required this.totalStock,
    required this.availableStock,
    required this.createdAt,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    totalStock: json["total_stock"],
    availableStock: json["available_stock"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category": category,
    "total_stock": totalStock,
    "available_stock": availableStock,
    "created_at": createdAt.toIso8601String(),
  };
}
