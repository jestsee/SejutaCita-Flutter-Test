// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserResponse userFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  final int totalCount;
  final bool incompleteResults;
  final List<UserItem> items;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    totalCount: json["total_count"],
    incompleteResults: json["incomplete_results"],
    items: List<UserItem>.from(json["items"].map((x) => UserItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "incomplete_results": incompleteResults,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class UserItem {
  UserItem({
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  final String login;
  final String avatarUrl;
  final String htmlUrl;

  factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
    login: json["login"],
    avatarUrl: json["avatar_url"],
    htmlUrl: json["html_url"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "avatar_url": avatarUrl,
    "html_url": htmlUrl,
  };
}
