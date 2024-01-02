import 'package:cloud_firestore/cloud_firestore.dart';

class MoodModel {
  String id;
  String creatorUid;
  String creator;
  String content;
  String moodEmoji;
  Timestamp? createdAt;

  MoodModel({
    required this.id,
    required this.creatorUid,
    required this.creator,
    required this.content,
    required this.moodEmoji,
    this.createdAt,
  });

  MoodModel.fromJson({
    required Map<String, dynamic> json,
    String? uid,
  })  : id = json["id"],
        creatorUid = json["creatorUid"],
        creator = json["creator"],
        content = json["content"],
        moodEmoji = json["moodEmoji"],
        createdAt = json["createdAt"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "creatorUid": creatorUid,
      "creator": creator,
      "content": content,
      "moodEmoji": moodEmoji,
      "createdAt": createdAt,
    };
  }

  MoodModel copyWith({
    String? id,
    String? creatorUid,
    String? creator,
    String? content,
    String? moodEmoji,
    Timestamp? createdAt,
  }) {
    return MoodModel(
      id: id ?? this.id,
      creatorUid: creatorUid ?? this.creatorUid,
      creator: creator ?? this.creator,
      content: content ?? this.content,
      moodEmoji: moodEmoji ?? this.moodEmoji,
      createdAt: createdAt ?? createdAt,
    );
  }
}
