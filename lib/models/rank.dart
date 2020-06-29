import 'dart:convert';

import 'user.dart';

class Rank {
  User user;
  int previousWeekRank;
  int currentWeekRank;
  int weekPoints;
  int totalPoints;
  int weekId;

  Rank({
    this.user,
    this.previousWeekRank,
    this.currentWeekRank,
    this.weekPoints = 0,
    this.totalPoints = 0,
    this.weekId,
  });

  Rank copyWith({
    User user,
    int previousWeekRank,
    int currentWeekRank,
    int weekPoints,
    int totalPoints,
    int weekId,
  }) {
    return Rank(
      user: user ?? this.user,
      previousWeekRank: previousWeekRank ?? this.previousWeekRank,
      currentWeekRank: currentWeekRank ?? this.currentWeekRank,
      weekPoints: weekPoints ?? this.weekPoints,
      totalPoints: totalPoints ?? this.totalPoints,
      weekId: weekId ?? this.weekId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(),
      'previousWeekRank': previousWeekRank,
      'currentWeekRank': currentWeekRank,
      'weekPoints': weekPoints,
      'totalPoints': totalPoints,
      'weekId': weekId,
    };
  }

  static Rank fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Rank(
      user: User.fromMap(map['user']),
      previousWeekRank: map['previousWeekRank'],
      currentWeekRank: map['currentWeekRank'],
      weekPoints: map['weekPoints'],
      totalPoints: map['totalPoints'],
      weekId: map['weekId'],
    );
  }

  String toJson() => json.encode(toMap());

  static Rank fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Rank(user: $user, previousWeekRank: $previousWeekRank, currentWeekRank: $currentWeekRank, weekPoints: $weekPoints, totalPoints: $totalPoints, weekId: $weekId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Rank &&
        o.user == user &&
        o.previousWeekRank == previousWeekRank &&
        o.currentWeekRank == currentWeekRank &&
        o.weekPoints == weekPoints &&
        o.totalPoints == totalPoints &&
        o.weekId == weekId;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        previousWeekRank.hashCode ^
        currentWeekRank.hashCode ^
        weekPoints.hashCode ^
        totalPoints.hashCode ^
        weekId.hashCode;
  }
}

class RankWeek {
  int id;
  DateTime fromDay;
  DateTime toDay;
  int weekNo;
  RankWeek({
    this.id,
    this.fromDay,
    this.toDay,
    this.weekNo,
  });

  RankWeek copyWith({
    int id,
    DateTime fromDay,
    DateTime toDay,
    int weekNo,
  }) {
    return RankWeek(
      id: id ?? this.id,
      fromDay: fromDay ?? this.fromDay,
      toDay: toDay ?? this.toDay,
      weekNo: weekNo ?? this.weekNo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromDay': fromDay?.millisecondsSinceEpoch,
      'toDay': toDay?.millisecondsSinceEpoch,
      'weekNo': weekNo,
    };
  }

  static RankWeek fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RankWeek(
      id: map['id'],
      fromDay: DateTime.fromMillisecondsSinceEpoch(map['fromDay']),
      toDay: DateTime.fromMillisecondsSinceEpoch(map['toDay']),
      weekNo: map['weekNo'],
    );
  }

  String toJson() => json.encode(toMap());

  static RankWeek fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'RankWeek(id: $id, fromDay: $fromDay, toDay: $toDay, weekNo: $weekNo)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RankWeek &&
        o.id == id &&
        o.fromDay == fromDay &&
        o.toDay == toDay &&
        o.weekNo == weekNo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ fromDay.hashCode ^ toDay.hashCode ^ weekNo.hashCode;
  }
}
