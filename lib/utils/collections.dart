import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/models.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Collections {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static final CollectionReference<UserModel> usersCollection = _db
      .collection("users")
      .withConverter<UserModel>(
        fromFirestore: (snapshot, options) => UserModel.fromFirestore(snapshot),
        toFirestore: (userModel, setOptions) =>
            UserModel.toFirestore(userModel),
      );

  static final CollectionReference<Class> classesCollection = _db
      .collection("classes")
      .withConverter<Class>(
        fromFirestore: (snapshot, options) => Class.fromFirestore(snapshot),
        toFirestore: (classModel, setOptions) => Class.toFirestore(classModel),
      );
  static final CollectionReference<Activity> activitiesCollection = _db
      .collection("activities")
      .withConverter<Activity>(
        fromFirestore: (snapshot, options) => Activity.fromFirestore(snapshot),
        toFirestore: (activity, setOptions) => Activity.toFirestore(activity),
      );
  static final CollectionReference<Task> tasksCollection =
      _db.collection("tasks").withConverter<Task>(
            fromFirestore: (snapshot, options) => Task.fromFirestore(snapshot),
            toFirestore: (task, setOptions) => Task.toFirestore(task),
          );
}
