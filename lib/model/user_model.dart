
import 'dart:convert';

List<UserModel> UserModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String UserModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    UserModel({
        required this.id,
        required this.name,
        required this.contacts,
        required this.url,
    });

    String id;
    String name;
    String contacts;
    String url;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        contacts: json["Contacts"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "Contacts": contacts,
        "url": url,
    };
}

