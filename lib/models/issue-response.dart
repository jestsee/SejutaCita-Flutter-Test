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
    required this.url,
    required this.repositoryUrl,
    required this.labelsUrl,
    required this.commentsUrl,
    required this.eventsUrl,
    required this.htmlUrl,
    required this.id,
    required this.nodeId,
    required this.number,
    required this.title,
    required this.user,
    required this.labels,
    required this.state,
    required this.locked,
    required this.assignee,
    required this.assignees,
    required this.milestone,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.closedAt,
    required this.authorAssociation,
    required this.activeLockReason,
    required this.body,
    required this.reactions,
    required this.timelineUrl,
    required this.performedViaGithubApp,
    required this.stateReason,
    required this.score,
  });

  final String url;
  final String repositoryUrl;
  final String labelsUrl;
  final String commentsUrl;
  final String eventsUrl;
  final String htmlUrl;
  final int id;
  final String nodeId;
  final int number;
  final String title;
  final Assignee user;
  final List<Label> labels;
  final String state;
  final bool locked;
  final Assignee assignee;
  final List<Assignee> assignees;
  final dynamic milestone;
  final int comments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic closedAt;
  final String authorAssociation;
  final dynamic activeLockReason;
  final String body;
  final Reactions reactions;
  final String timelineUrl;
  final dynamic performedViaGithubApp;
  final dynamic stateReason;
  final int score;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    url: json["url"],
    repositoryUrl: json["repository_url"],
    labelsUrl: json["labels_url"],
    commentsUrl: json["comments_url"],
    eventsUrl: json["events_url"],
    htmlUrl: json["html_url"],
    id: json["id"],
    nodeId: json["node_id"],
    number: json["number"],
    title: json["title"],
    user: Assignee.fromJson(json["user"]),
    labels: List<Label>.from(json["labels"].map((x) => Label.fromJson(x))),
    state: json["state"],
    locked: json["locked"],
    assignee: Assignee.fromJson(json["assignee"]),
    assignees: List<Assignee>.from(json["assignees"].map((x) => Assignee.fromJson(x))),
    milestone: json["milestone"],
    comments: json["comments"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    closedAt: json["closed_at"],
    authorAssociation: json["author_association"],
    activeLockReason: json["active_lock_reason"],
    body: json["body"],
    reactions: Reactions.fromJson(json["reactions"]),
    timelineUrl: json["timeline_url"],
    performedViaGithubApp: json["performed_via_github_app"],
    stateReason: json["state_reason"],
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "repository_url": repositoryUrl,
    "labels_url": labelsUrl,
    "comments_url": commentsUrl,
    "events_url": eventsUrl,
    "html_url": htmlUrl,
    "id": id,
    "node_id": nodeId,
    "number": number,
    "title": title,
    "user": user.toJson(),
    "labels": List<dynamic>.from(labels.map((x) => x.toJson())),
    "state": state,
    "locked": locked,
    "assignee": assignee.toJson(),
    "assignees": List<dynamic>.from(assignees.map((x) => x.toJson())),
    "milestone": milestone,
    "comments": comments,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "closed_at": closedAt,
    "author_association": authorAssociation,
    "active_lock_reason": activeLockReason,
    "body": body,
    "reactions": reactions.toJson(),
    "timeline_url": timelineUrl,
    "performed_via_github_app": performedViaGithubApp,
    "state_reason": stateReason,
    "score": score,
  };
}

class Assignee {
  Assignee({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.siteAdmin,
  });

  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String gravatarId;
  final String url;
  final String htmlUrl;
  final String followersUrl;
  final String followingUrl;
  final String gistsUrl;
  final String starredUrl;
  final String subscriptionsUrl;
  final String organizationsUrl;
  final String reposUrl;
  final String eventsUrl;
  final String receivedEventsUrl;
  final String type;
  final bool siteAdmin;

  factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
    login: json["login"],
    id: json["id"],
    nodeId: json["node_id"],
    avatarUrl: json["avatar_url"],
    gravatarId: json["gravatar_id"],
    url: json["url"],
    htmlUrl: json["html_url"],
    followersUrl: json["followers_url"],
    followingUrl: json["following_url"],
    gistsUrl: json["gists_url"],
    starredUrl: json["starred_url"],
    subscriptionsUrl: json["subscriptions_url"],
    organizationsUrl: json["organizations_url"],
    reposUrl: json["repos_url"],
    eventsUrl: json["events_url"],
    receivedEventsUrl: json["received_events_url"],
    type: json["type"],
    siteAdmin: json["site_admin"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "id": id,
    "node_id": nodeId,
    "avatar_url": avatarUrl,
    "gravatar_id": gravatarId,
    "url": url,
    "html_url": htmlUrl,
    "followers_url": followersUrl,
    "following_url": followingUrl,
    "gists_url": gistsUrl,
    "starred_url": starredUrl,
    "subscriptions_url": subscriptionsUrl,
    "organizations_url": organizationsUrl,
    "repos_url": reposUrl,
    "events_url": eventsUrl,
    "received_events_url": receivedEventsUrl,
    "type": type,
    "site_admin": siteAdmin,
  };
}

class Label {
  Label({
    required this.id,
    required this.nodeId,
    required this.url,
    required this.name,
    required this.color,
    required this.labelDefault,
    required this.description,
  });

  final int id;
  final String nodeId;
  final String url;
  final String name;
  final String color;
  final bool labelDefault;
  final dynamic description;

  factory Label.fromJson(Map<String, dynamic> json) => Label(
    id: json["id"],
    nodeId: json["node_id"],
    url: json["url"],
    name: json["name"],
    color: json["color"],
    labelDefault: json["default"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "node_id": nodeId,
    "url": url,
    "name": name,
    "color": color,
    "default": labelDefault,
    "description": description,
  };
}

class Reactions {
  Reactions({
    required this.url,
    required this.totalCount,
    required this.the1,
    required this.reactions1,
    required this.laugh,
    required this.hooray,
    required this.confused,
    required this.heart,
    required this.rocket,
    required this.eyes,
  });

  final String url;
  final int totalCount;
  final int the1;
  final int reactions1;
  final int laugh;
  final int hooray;
  final int confused;
  final int heart;
  final int rocket;
  final int eyes;

  factory Reactions.fromJson(Map<String, dynamic> json) => Reactions(
    url: json["url"],
    totalCount: json["total_count"],
    the1: json["+1"],
    reactions1: json["-1"],
    laugh: json["laugh"],
    hooray: json["hooray"],
    confused: json["confused"],
    heart: json["heart"],
    rocket: json["rocket"],
    eyes: json["eyes"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "total_count": totalCount,
    "+1": the1,
    "-1": reactions1,
    "laugh": laugh,
    "hooray": hooray,
    "confused": confused,
    "heart": heart,
    "rocket": rocket,
    "eyes": eyes,
  };
}
