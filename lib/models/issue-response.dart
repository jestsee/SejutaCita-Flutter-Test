// To parse this JSON data, do
//
//     final issue = issueFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Issue issueFromJson(String str) => Issue.fromJson(json.decode(str));

String issueToJson(Issue data) => json.encode(data.toJson());

class Issue {
  Issue({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  final int totalCount;
  final bool incompleteResults;
  final List<Item> items;

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
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

class Item {
  Item({
    required this.title,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  final String title;
  final String state;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(
        title: json["title"] as String,
        state: json["state"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "title": title,
        "state": state,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}