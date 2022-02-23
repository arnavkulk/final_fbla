import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:final_fbla/models/activity.dart';

class ActivityService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference<Activity> _activitiesCollection =
      Collections.activitiesCollection;

  static Future<List<Activity>> getActivities() async {
    QuerySnapshot<Activity> res = await _activitiesCollection
        // .where(FieldPath.documentId, whereIn: classIds)
        .get();

    return res.docs.map((e) => e.data()).toList();
  }

  static Stream<List<Activity>> streamActivities(List<String> activityIds) {
    return _activitiesCollection
        // .where(FieldPath.documentId, whereIn: activityIds)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  static Future<String> createActivity(Activity classModel) async {
    DocumentReference<Activity> doc = _activitiesCollection.doc();
    Activity newActivity = Activity.fromJson({
      ...Activity.toJson(classModel),
      'id': doc.id,
    });
    await doc.set(newActivity);
    return doc.id;
  }
}
