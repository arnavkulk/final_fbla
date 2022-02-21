import 'package:cloud_firestore/cloud_firestore.dart';

import 'location.dart';

class Room extends Location {
  final String building;
  final int number;

  Room({
    required GeoPoint geoPoint,
    required this.building,
    required this.number,
  }) : super(
          indoors: true,
          geoPoint: geoPoint,
          name: "$building-$number",
        );

  @override
  String toString() {
    return super.name;
  }
}
