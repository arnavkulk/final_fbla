import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  String name;
  String description;
  String classId;
  Timestamp deadline;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.deadline,
    required this.classId,
  });

  static Map<String, dynamic> toFirestore(Task activity) {
    return Task.toJson(activity);
  }

  factory Task.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception('Document is null');
    }
    return Task.fromJson({'id': doc.id, ...doc.data()!});
  }

  factory Task.fromJson(Map<String, dynamic> data) {
    return Task(
      id: data['id'] as String,
      name: data['name'] as String,
      description: data['description'] as String,
      classId: data['classId'] as String,
      deadline: data['deadline'] as Timestamp,
    );
  }

  static Map<String, dynamic> toJson(Task object) {
    return {
      'id': object.id,
      'name': object.name,
      'classId': object.classId,
      'description': object.description,
      'deadline': object.deadline,
    };
  }
}
