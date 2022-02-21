import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/user_model.dart';
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
}
