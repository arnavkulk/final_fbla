import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  GeoPoint geoPoint;
  String name;
  bool indoors;

  Location({
    required this.geoPoint,
    required this.name,
    required this.indoors,
  });
}
