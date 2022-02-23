import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/task.dart';
import 'package:final_fbla/services/task_service.dart';
import 'package:final_fbla/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Task> get tasks => _tasks;
  List<StreamSubscription> _subscriptions = [];

  void setUpStream(List<String> classIds) async {
    print('start');
    StreamSubscription sub = Collections.tasksCollection
        .orderBy('deadline')
        // .where('classId', whereIn: classIds)
        .snapshots()
        .listen((snapshot) {
      print('listen: ${snapshot.docs.length}');
      _tasks = snapshot.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
    _subscriptions.add(sub);
  }

  void cancelListeners() {
    _subscriptions.forEach((sub) {
      sub.cancel();
    });
  }

  void loadTasks(List<String> classIds) async {
    if (_auth.currentUser == null) {
      clear();
      return;
    }
    try {
      _tasks = await TaskService.getTasks(classIds);
      setUpStream(classIds);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setUser(List<Task> classes) {
    _tasks = classes;
    notifyListeners();
  }

  void clear() {
    print('clear');
    _tasks = [];
    cancelListeners();
    notifyListeners();
  }
}
