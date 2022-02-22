import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final String id;
  GeoPoint geoPoint;
  String name;
  bool indoors;

  Location({
    required this.id,
    required this.geoPoint,
    required this.name,
    required this.indoors,
  });

  static Map<String, dynamic> toFirestore(Location activity) {
    return Location.toJson(activity);
  }

  factory Location.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception('Document is null');
    }
    return Location.fromJson({'id': doc.id, ...doc.data()!});
  }

  factory Location.fromJson(Map<String, dynamic> data) {
    return Location(
      id: data['id'] as String,
      name: data['name'] as String,
      indoors: data['indoors'] as bool,
      geoPoint: data['geoPoint'] as GeoPoint,
    );
  }

  static Map<String, dynamic> toJson(Location object) {
    return {
      'id': object.id,
      'name': object.name,
      'indoors': object.indoors,
      'geoPoint': object.geoPoint,
    };
  }
}
