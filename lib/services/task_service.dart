import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/task.dart';
import 'package:final_fbla/utils/utils.dart';
import 'package:final_fbla/models/class.dart';

class TaskService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference<Task> _tasksCollection =
      Collections.tasksCollection;

  static Future<List<Task>> getTasks(List<String> classIds) async {
    if (classIds.isEmpty) {
      return [];
    }
    QuerySnapshot<Task> res = await _tasksCollection
        .where('classId', whereIn: classIds)
        .orderBy('deadline')
        .get();

    return res.docs.map((e) => e.data()).toList();
  }

  static Stream<List<Task>> streamClasses(List<String> classIds) {
    return Collections.tasksCollection
        .where('classId', whereIn: classIds)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  static Future<String> createClass(Task task) async {
    DocumentReference<Task> doc = _tasksCollection.doc();
    Task newTask = Task.fromJson({
      ...Task.toJson(task),
      'id': doc.id,
    });
    await doc.set(newTask);
    return doc.id;
  }
}
