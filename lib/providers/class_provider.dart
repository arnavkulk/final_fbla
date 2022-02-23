import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/class.dart';
import 'package:final_fbla/services/auth_service.dart';
import 'package:final_fbla/services/class_service.dart';
import 'package:final_fbla/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ClassProvider extends ChangeNotifier {
  List<Class> _classes = [];
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Class> get classes => _classes;
  List<StreamSubscription> _subscriptions = [];

  void setUpStream(List<String> classIds) async {
    StreamSubscription sub = Collections.classesCollection
        .where(FieldPath.documentId, whereIn: classIds)
        .snapshots()
        .listen((snapshot) {
      _classes = snapshot.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
    _subscriptions.add(sub);
  }

  void cancelListeners() {
    _subscriptions.forEach((sub) {
      sub.cancel();
    });
  }

  void loadClasses(List<String> classIds) async {
    if (_auth.currentUser == null) {
      clear();
      return;
    }
    try {
      _classes = await ClassService.getClasses(classIds);
      setUpStream(classIds);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setUser(List<Class> classes) {
    _classes = classes;
    notifyListeners();
  }

  void clear() {
    _classes = [];
    cancelListeners();
    notifyListeners();
  }
}
