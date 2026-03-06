import 'dart:convert';

List<ProfileModel> profileModelFromJson(String str) => List<ProfileModel>.from(
  json.decode(str).map((x) => ProfileModel.fromJson(x)),
);

String profileModelToJson(List<ProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileModel {
  String id;
  String email;
  DateTime? createdAt;
  String name;
  String gender;

  ProfileModel({
    required this.id,
    required this.email,
    this.createdAt,
    required this.name,
    required this.gender,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    email: json["email"],
    createdAt: DateTime.parse(json["created_at"]),
    name: json["name"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "gender": gender,
  };
}
