import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/models/mood_model.dart';

const int fetchMoodsLimit = 10;

class MoodsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMoods({
    String? uid,
    Timestamp? lastItemCreatedAt,
  }) async {
    // print("fetchThreads: $uid");
    // await Future.delayed(const Duration(seconds: 2));
    Query<Map<String, dynamic>> query;

    if (uid == null) {
      query = _db
          .collection("moods")
          .orderBy("createdAt", descending: true)
          .limit(fetchMoodsLimit);
    } else {
      query = _db
          .collection("moods")
          .where("creatorUid", isEqualTo: uid)
          .orderBy("createdAt", descending: true)
          .limit(fetchMoodsLimit);
    }
    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  Future<String> postMood(MoodModel data) async {
    final newPostRef = _db.collection("moods").doc();

    await newPostRef.set({
      ...data.toJson(),
      "createdAt": FieldValue.serverTimestamp(),
      "id": newPostRef.id,
    });
    return newPostRef.id;
  }
}

final moodsRepo = Provider(
  (ref) => MoodsRepository(),
);
