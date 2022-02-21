import 'location.dart';

class Event {
  Location location;
  String name;
  int capacity;
  List<int> gradeLevels;
  String description;

  Event({
    required this.location,
    required this.name,
    required this.capacity,
    required this.gradeLevels,
    required this.description,
  });
}
