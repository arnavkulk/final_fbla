import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/activity.dart';
import 'package:final_fbla/services/activity_service.dart';
import 'package:final_fbla/services/auth_service.dart';
import 'package:final_fbla/services/class_service.dart';
import 'package:final_fbla/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ActivityProvider extends ChangeNotifier {
  List<Activity> _activities = [];
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Activity> get activities => _activities;
  List<StreamSubscription> _subscriptions = [];

  void setUpStream() async {
    print('start');
    StreamSubscription sub = Collections.activitiesCollection
        // .where(FieldPath.documentId, whereIn: activityIds)
        .snapshots()
        .listen((snapshot) {
      print('listen');
      _activities = snapshot.docs.map((e) => e.data()).toList();

      notifyListeners();
    });
    _subscriptions.add(sub);
  }

  void cancelListeners() {
    _subscriptions.forEach((sub) {
      sub.cancel();
    });
  }

  void loadActivities() async {
    if (_auth.currentUser == null) {
      clear();
      return;
    }
    try {
      _activities = await ActivityService.getActivities();
      setUpStream();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setActivities(List<Activity> activities) {
    _activities = _activities;
    notifyListeners();
  }

  void clear() {
    print('clear');
    _activities = [];
    cancelListeners();
    notifyListeners();
  }
}
