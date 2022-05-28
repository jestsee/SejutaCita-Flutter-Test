// To parse this JSON data, do
//
//     final repository = repositoryFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

RepositoryResponse repositoryFromJson(String str) =>
    RepositoryResponse.fromJson(json.decode(str));

String repositoryToJson(RepositoryResponse data) => json.encode(data.toJson());

class RepositoryResponse {
  RepositoryResponse({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  final int totalCount;
  final bool incompleteResults;
  final List<Item> items;

  factory RepositoryResponse.fromJson(Map<String, dynamic> json) =>
      RepositoryResponse(
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
  Item({
    required this.name,
    required this.fullName,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
  });

  final String fullName;
  final String name;
  final Owner owner;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime pushedAt;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        fullName: json["full_name"],
        owner: Owner.fromJson(json["owner"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pushedAt: DateTime.parse(json["pushed_at"]),
        stargazersCount: json["stargazers_count"],
        watchersCount: json["watchers_count"],
        forksCount: json["forks_count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "full_name": fullName,
        "owner": owner.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pushed_at": pushedAt.toIso8601String(),
        "stargazers_count": stargazersCount,
        "watchers_count": watchersCount,
        "forks_count": forksCount,
      };

  Item.emptyItem()
      : fullName = "unknown",
        name = "unknown",
        owner = Owner(avatarUrl: "unknown"),
        createdAt = DateTime.utc(0),
        pushedAt = DateTime.utc(0),
        updatedAt = DateTime.utc(0),
        stargazersCount = -1,
        watchersCount = -1,
        forksCount = -1;

  bool isEmpty() {
    return name == "unknown";
  }

  @override
  List<Object?> get props => [
        fullName,
        name,
        owner.avatarUrl,
        createdAt,
        stargazersCount,
        watchersCount,
        forksCount
      ];
}

class Owner {
  Owner({
    required this.avatarUrl,
  });

  final String avatarUrl;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
      };
}
