import 'package:cloud_firestore/cloud_firestore.dart';

import 'location.dart';

class Room extends Location {
  final String building;
  final int number;

  Room({
    required GeoPoint geoPoint,
    required this.building,
    required this.number,
    required String id,
  }) : super(
          indoors: true,
          geoPoint: geoPoint,
          name: "$building-$number",
          id: id,
        );

  @override
  String toString() {
    return super.name;
  }

  static Map<String, dynamic> toFirestore(Room activity) {
    return Room.toJson(activity);
  }

  factory Room.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception('Document is null');
    }
    return Room.fromJson({'id': doc.id, ...doc.data()!});
  }

  factory Room.fromJson(Map<String, dynamic> data) {
    return Room(
      id: data['id'] as String,
      geoPoint: data['geoPoint'] as GeoPoint,
      building: data['building'] as String,
      number: data['number'] as int,
    );
  }

  static Map<String, dynamic> toJson(Room object) {
    return {
      'id': object.id,
      'geoPoint': object.geoPoint,
      'building': object.building,
      'number': object.number,
    };
  }
}
