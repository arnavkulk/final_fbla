import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/user_model.dart';
import 'package:final_fbla/utils/collections.dart';

class UserService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference<UserModel> _usersCollection =
      Collections.usersCollection;

  static Future<void> addClass(String uid, String classId) async {
    await _usersCollection.doc(uid).update(
      {
        'classIds': FieldValue.arrayUnion([classId])
      },
    );
  }

  static Future<void> removeClass(String uid, String classId) async {
    await _usersCollection.doc(uid).update(
      {
        'classIds': FieldValue.arrayRemove([classId])
      },
    );
  }

  static Future<void> addActivity(String uid, String activityId) async {
    await _usersCollection.doc(uid).update(
      {
        'activityIds': FieldValue.arrayUnion([activityId])
      },
    );
  }

  static Future<void> removeActivity(String uid, String activityId) async {
    await _usersCollection.doc(uid).update(
      {
        'activityIds': FieldValue.arrayRemove([activityId])
      },
    );
  }
}
