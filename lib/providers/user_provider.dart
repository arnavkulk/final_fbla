import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/user_model.dart';
import 'package:final_fbla/services/auth_service.dart';
import 'package:final_fbla/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? get user => _user;
  List<StreamSubscription> _subscriptions = [];

  void setUpStream(String uid) async {
    print('start');
    StreamSubscription sub =
        Collections.usersCollection.doc(uid).snapshots().listen((snapshot) {
      print('listen');
      _user = snapshot.data();
      notifyListeners();
    });
    _subscriptions.add(sub);
  }

  void cancelListeners() {
    _subscriptions.forEach((sub) {
      sub.cancel();
    });
  }

  void loadUser() async {
    if (_auth.currentUser == null) {
      clear();
      return;
    }
    try {
      _user = await AuthService.getUser(_auth.currentUser!.uid);
      setUpStream(_auth.currentUser!.uid);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  void clear() {
    print('clear');
    _user = null;
    cancelListeners();
    notifyListeners();
  }
}
