import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/usertype.dart';

class UserModel {
  final String id;
  String firstName, lastName;
  String email;
  UserType userType;
  final String fcmToken;
  List<String> classIds;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.fcmToken,
    required this.classIds,
    required this.userType,
  });
  static Map<String, dynamic> toFirestore(UserModel user) {
    return UserModel.toJson(user);
  }

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception('Document is null');
    }
    return UserModel.fromJson({'id': doc.id, ...doc.data()!});
  }

  factory UserModel.fromFirebase(DocumentSnapshot<UserModel> doc) {
    UserModel? user = doc.data();
    if (user == null) {
      throw Exception('Document is null');
    }

    return UserModel(
      id: doc.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      fcmToken: user.fcmToken,
      classIds: user.classIds,
      userType: user.userType,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    print('here');
    return UserModel(
      id: data['id'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      email: data['email'] as String,
      fcmToken: data['fcmToken'] as String,
      classIds: data['classIds'].map<String>((e) => e.toString()).toList()
          as List<String>,
      userType: UserTypeUtils.fromString(data['userType']),
    );
  }

  static Map<String, dynamic> toJson(UserModel object) {
    return {
      'id': object.id,
      'firstName': object.firstName,
      'lastName': object.lastName,
      'email': object.email,
      'fcmToken': object.fcmToken,
      'classIds': object.classIds,
      'userType': object.userType.value,
    };
  }
}
