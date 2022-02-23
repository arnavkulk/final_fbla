import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/usertype.dart';

class UserModel {
  final String uid;
  final String id;
  String firstName, lastName;
  String email;
  UserType userType;
  final String fcmToken;
  List<String> classIds, activityIds;

  UserModel({
    required this.uid,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.fcmToken,
    required this.classIds,
    required this.userType,
    required this.activityIds,
  });

  static Map<String, dynamic> toFirestore(UserModel user) {
    return UserModel.toJson(user);
  }

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception('Document is null');
    }
    return UserModel.fromJson({'uid': doc.id, ...doc.data()!});
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] as String,
      id: data['id'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      email: data['email'] as String,
      fcmToken: data['fcmToken'] as String,
      classIds: data['classIds'].map<String>((e) => e.toString()).toList()
          as List<String>,
      activityIds: data['activityIds'].map<String>((e) => e.toString()).toList()
          as List<String>,
      userType: UserTypeUtils.fromString(data['userType']),
    );
  }

  static Map<String, dynamic> toJson(UserModel object) {
    return {
      'uid': object.uid,
      'id': object.id,
      'firstName': object.firstName,
      'lastName': object.lastName,
      'email': object.email,
      'fcmToken': object.fcmToken,
      'classIds': object.classIds,
      'userType': object.userType.value,
      'activityIds': object.activityIds,
    };
  }
}
