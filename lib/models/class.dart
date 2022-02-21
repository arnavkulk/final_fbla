import 'room.dart';

class Class {
  final String id;
  String subject;
  String description;
  List<int> gradeLevels;
  String teacherId;
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
  });
}
