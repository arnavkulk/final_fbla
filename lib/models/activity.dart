import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String id;
  final String name;
  final int members;
  final String description;
  final String image;

  Activity({
    required this.id,
    required this.name,
    required this.members,
    required this.description,
    required this.image,
  });

  static Map<String, dynamic> toFirestore(Activity activity) {
    return Activity.toJson(activity);
  }

  factory Activity.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception('Document is null');
    }
    return Activity.fromJson({'id': doc.id, ...doc.data()!});
  }

  factory Activity.fromJson(Map<String, dynamic> data) {
    return Activity(
      id: data['id'] as String,
      name: data['name'] as String,
      image: data['image'] as String,
      description: data['description'] as String,
      members: data['members'] as int,
    );
  }

  static Map<String, dynamic> toJson(Activity object) {
    return {
      'id': object.id,
      'name': object.name,
      'image': object.image,
      'description': object.description,
      'members': object.members,
    };
  }
}
