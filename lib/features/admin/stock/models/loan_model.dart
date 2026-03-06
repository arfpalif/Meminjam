import 'dart:convert';

List<LoanModel> loanModelFromJson(String str) =>
    List<LoanModel>.from(json.decode(str).map((x) => LoanModel.fromJson(x)));

String loanModelToJson(List<LoanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoanModel {
  String id;
  String itemId;
  String borrowerName;
  DateTime loanDate;
  DateTime dueDate;
  DateTime? returnDate;
  DateTime createdAt;

  LoanModel({
    required this.id,
    required this.itemId,
    required this.borrowerName,
    required this.loanDate,
    required this.dueDate,
    this.returnDate,
    required this.createdAt,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) => LoanModel(
    id: json["id"],
    itemId: json["item_id"],
    borrowerName: json["borrower_name"],
    loanDate: DateTime.parse(json["loan_date"]),
    dueDate: DateTime.parse(json["due_date"]),
    returnDate: json["return_date"] != null
        ? DateTime.parse(json["return_date"])
        : null,
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_id": itemId,
    "borrower_name": borrowerName,
    "loan_date":
        "${loanDate.year}-${loanDate.month.toString().padLeft(2, '0')}-${loanDate.day.toString().padLeft(2, '0')}",
    "due_date":
        "${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
    "return_date": returnDate != null
        ? "${returnDate!.year}-${returnDate!.month.toString().padLeft(2, '0')}-${returnDate!.day.toString().padLeft(2, '0')}"
        : null,
  };

  bool get isActive => returnDate == null;

  bool get isOverdue => returnDate == null && DateTime.now().isAfter(dueDate);
}
