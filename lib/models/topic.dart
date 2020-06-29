import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'user.dart';

class Topic {
  int id;
  User author;
  String title;
  String body;
  int points;
  List<Comment> comments;
  DateTime datetime;
  Topic({
    this.id,
    this.author,
    this.title,
    this.body,
    this.points = 0,
    List<Comment> comments,
    this.datetime,
  }) : comments = comments ?? [];

  Topic copyWith({
    int id,
    User author,
    String title,
    String body,
    int points,
    List<Comment> comments,
    DateTime datetime,
  }) {
    return Topic(
      id: id ?? this.id,
      author: author ?? this.author,
      title: title ?? this.title,
      body: body ?? this.body,
      points: points ?? this.points,
      comments: comments ?? this.comments,
      datetime: datetime ?? this.datetime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author?.toMap(),
      'title': title,
      'body': body,
      'points': points,
      'comments': comments?.map((x) => x?.toMap())?.toList(),
      'datetime': datetime?.millisecondsSinceEpoch,
    };
  }

  static Topic fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Topic(
      id: map['id'],
      author: User.fromMap(map['author']),
      title: map['title'],
      body: map['body'],
      points: map['points'],
      comments:
          List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))),
      datetime: DateTime.fromMillisecondsSinceEpoch(map['datetime']),
    );
  }

  String toJson() => json.encode(toMap());

  static Topic fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Topic(id: $id, author: $author, title: $title, body: $body, points: $points, comments: $comments, datetime: $datetime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Topic &&
        o.id == id &&
        o.author == author &&
        o.title == title &&
        o.body == body &&
        o.points == points &&
        listEquals(o.comments, comments) &&
        o.datetime == datetime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        author.hashCode ^
        title.hashCode ^
        body.hashCode ^
        points.hashCode ^
        comments.hashCode ^
        datetime.hashCode;
  }
}

class Comment {
  int id;
  User author;
  String comment;
  int points = 0;
  DateTime datetime;
  Comment({
    this.id,
    this.author,
    this.comment,
    this.points = 0,
    this.datetime,
  });

  Comment copyWith({
    int id,
    User author,
    String comment,
    int points,
    DateTime datetime,
  }) {
    return Comment(
      id: id ?? this.id,
      author: author ?? this.author,
      comment: comment ?? this.comment,
      points: points ?? this.points,
      datetime: datetime ?? this.datetime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author?.toMap(),
      'comment': comment,
      'points': points,
      'datetime': datetime?.millisecondsSinceEpoch,
    };
  }

  static Comment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      id: map['id'],
      author: User.fromMap(map['author']),
      comment: map['comment'],
      points: map['points'],
      datetime: DateTime.fromMillisecondsSinceEpoch(map['datetime']),
    );
  }

  String toJson() => json.encode(toMap());

  static Comment fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(id: $id, author: $author, comment: $comment, points: $points, datetime: $datetime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Comment &&
        o.id == id &&
        o.author == author &&
        o.comment == comment &&
        o.points == points &&
        o.datetime == datetime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        author.hashCode ^
        comment.hashCode ^
        points.hashCode ^
        datetime.hashCode;
  }
}
