import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoggedIn = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<StreamSubscription> _subs = [];

  AuthProvider() {
    _init();
  }

  User? get user => _user;
  bool get isLoggedIn => _isLoggedIn;
  bool get emailVerified => _isLoggedIn && _user!.emailVerified;
  bool get isAuthenticated => _isLoggedIn && emailVerified;

  void _init() {
    StreamSubscription sub = _auth.userChanges().listen((User? user) {
      _user = user;
      _isLoggedIn = user != null;
      notifyListeners();
    });
    _subs.add(sub);
  }

  @override
  void dispose() {
    for (StreamSubscription sub in _subs) {
      sub.cancel();
    }
    super.dispose();
  }
}
