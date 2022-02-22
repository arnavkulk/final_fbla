import 'package:cloud_firestore/cloud_firestore.dart';

import 'location.dart';

class Event {
  final String id;
  Location location;
  String name;
  int capacity;
  List<int> gradeLevels;
  String description;

  Event({
    required this.id,
    required this.location,
    required this.name,
    required this.capacity,
    required this.gradeLevels,
    required this.description,
  });

  static Map<String, dynamic> toFirestore(Event activity) {
    return Event.toJson(activity);
  }

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception('Document is null');
    }
    return Event.fromJson({'id': doc.id, ...doc.data()!});
  }

  factory Event.fromJson(Map<String, dynamic> data) {
    return Event(
      id: data['id'] as String,
      name: data['name'] as String,
      description: data['description'] as String,
      gradeLevels: (data['gradeLevels'] as List<dynamic>).cast<int>(),
      capacity: data['capacity'] as int,
      location: Location.fromJson(data['room'] as Map<String, dynamic>),
    );
  }

  static Map<String, dynamic> toJson(Event object) {
    return {
      'id': object.id,
      'name': object.name,
      'description': object.description,
      'gradeLevels': object.gradeLevels,
      'capacity': object.capacity,
      'room': Location.toJson(object.location),
    };
  }
}
