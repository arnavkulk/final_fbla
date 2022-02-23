import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:final_fbla/models/class.dart';

class ClassService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference<Class> _classesCollection =
      Collections.classesCollection;

  static Future<List<Class>> getClasses(List<String> classIds) async {
    if (classIds.isEmpty) {
      return [];
    }
    QuerySnapshot<Class> res = await _classesCollection
        .where(FieldPath.documentId, whereIn: classIds)
        .get();

    return res.docs.map((e) => e.data()).toList();
  }

  static Stream<List<Class>> streamClasses(List<String> classIds) {
    return Collections.classesCollection
        .where(FieldPath.documentId, whereIn: classIds)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  static Future<String> createClass(Class classModel) async {
    DocumentReference<Class> doc = _classesCollection.doc();
    Class newClass = Class.fromJson({
      ...Class.toJson(classModel),
      'id': doc.id,
    });
    await doc.set(newClass);
    return doc.id;
  }
}
