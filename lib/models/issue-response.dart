// To parse this JSON data, do
//
//     final issue = issueFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

DataResponse issueFromJson(String str) => DataResponse.fromJson(json.decode(str));

String issueToJson(DataResponse data) => json.encode(data.toJson());

class DataResponse<T> {
  DataResponse({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  final int totalCount;
  final bool incompleteResults;
  final List<IssueItem> items;

  factory DataResponse.fromJson(Map<String, dynamic> json) => DataResponse(
    totalCount: json["total_count"],
    incompleteResults: json["incomplete_results"],
    items: List<IssueItem>.from(json["items"].map((x) => IssueItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "incomplete_results": incompleteResults,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class IssueItem extends Equatable{
  IssueItem(
    this.title,
    this.state,
    this.createdAt,
    this.updatedAt,
  );

  IssueItem.emptyItem()
      : title = "unknown",
        state = "unknown",
        createdAt = DateTime.utc(0),
        updatedAt = DateTime.utc(0);

  final String title;
  final String state;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory IssueItem.fromJson(Map<String, dynamic> json) {
    return IssueItem(
        json["title"] as String,
        json["state"],
        DateTime.parse(json["created_at"]),
        DateTime.parse(json["updated_at"]),
      );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
        "title": title,
        "state": state,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
  }

  @override
  List<Object?> get props => [title, state, createdAt, updatedAt];
}