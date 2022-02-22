import 'package:cloud_firestore/cloud_firestore.dart';

import 'room.dart';

class Class {
  final String id;
  String subject;
  String description;
  List<int> gradeLevels;
  String teacherId;
  String teacherName;
  int capacity;
  Room room;
  List<String> studentIds;
  int period;

  Class({
    required this.id,
    required this.subject,
    required this.description,
    required this.gradeLevels,
    required this.teacherId,
    required this.capacity,
    required this.room,
    required this.period,
    required this.studentIds,
    required this.teacherName,
  });

  static Map<String, dynamic> toFirestore(Class activity) {
    return Class.toJson(activity);
  }

  factory Class.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception('Document is null');
    }
    return Class.fromJson({'id': doc.id, ...doc.data()!});
  }

  factory Class.fromJson(Map<String, dynamic> data) {
    return Class(
      id: data['id'] as String,
      subject: data['subject'] as String,
      teacherId: data['teacherId'] as String,
      description: data['description'] as String,
      teacherName: data['teacherName'] as String,
      gradeLevels: (data['gradeLevels'] as List<dynamic>).cast<int>(),
      capacity: data['capacity'] as int,
      room: Room.fromJson(data['room'] as Map<String, dynamic>),
      period: data['period'] as int,
      studentIds: (data['studentIds'] as List<dynamic>).cast<String>(),
    );
  }

  static Map<String, dynamic> toJson(Class object) {
    return {
      'id': object.id,
      'subject': object.subject,
      'teacherId': object.teacherId,
      'description': object.description,
      'teacherName': object.teacherName,
      'gradeLevels': object.gradeLevels,
      'capacity': object.capacity,
      'room': Room.toJson(object.room),
      'period': object.period,
      'studentIds': object.studentIds,
    };
  }
}
