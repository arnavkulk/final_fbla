import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/usertype.dart';

class MyUser {
  final String id;
  String firstName, lastName;
  String email;
  UserType userType;
  final String fcmToken;
  List<String> classIds;

  MyUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.fcmToken,
    required this.classIds,
    required this.userType,
  });

  factory MyUser.fromFirebase(DocumentSnapshot<MyUser> doc) {
    MyUser? user = doc.data();
    if (user == null) {
      throw Exception('Document is null');
    }

    return MyUser(
      id: doc.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      fcmToken: user.fcmToken,
      classIds: user.classIds,
      userType: user.userType,
    );
  }

  factory MyUser.fromJson(Map<String, dynamic> data) {
    return MyUser(
      id: data['id'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      email: data['email'] as String,
      fcmToken: data['fcmToken'] as String,
      classIds: data['classIds'] as List<String>,
      userType: UserTypeUtils.fromString(data['userType']),
    );
  }

  Map<String, dynamic> toJson(MyUser object) {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'fcmToken': fcmToken,
      'classIds': classIds,
      'userType': userType.value,
    };
  }
}
