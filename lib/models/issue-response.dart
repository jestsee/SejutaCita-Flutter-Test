// To parse this JSON data, do
//
//     final issue = issueFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

IssueResponse issueFromJson(String str) =>
    IssueResponse.fromJson(json.decode(str));

String issueToJson(IssueResponse data) => json.encode(data.toJson());

class IssueResponse {
  IssueResponse({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  final int totalCount;
  final bool incompleteResults;
  final List<Item> items;

  factory IssueResponse.fromJson(Map<String, dynamic> json) => IssueResponse(
        totalCount: json["total_count"],
        incompleteResults: json["incomplete_results"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "incomplete_results": incompleteResults,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item extends Equatable {
  Item(
      {required this.title,
      required this.state,
      required this.createdAt,
      required this.updatedAt,
      required this.user});

  final String title;
  final String state;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"] as String,
        state: json["state"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "state": state,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };

  Item.emptyItem()
      : title = "unknown",
        state = "unknown",
        createdAt = DateTime.utc(0),
        updatedAt = DateTime.utc(0),
        user = User(avatarUrl: "-");

  @override
  List<Object?> get props =>
      [title, state, createdAt, updatedAt, user.avatarUrl];
}

class User {
  User({
    required this.avatarUrl,
  });

  final String avatarUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
      };
}
