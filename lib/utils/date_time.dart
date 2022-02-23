import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeUtils {
  static Map<int, Map<String, String>> periodToTimestamp({DateTime? date}) {
    DateTime today = date ?? DateTime.now();
    if (today.weekday == 1 || today.weekday == 4) {
      return {
        1: {
          'time': '8:00',
          'ampm': 'AM',
        },
        2: {
          'time': '9:40',
          'ampm': 'AM',
        },
        3: {
          'time': '11:35',
          'ampm': 'AM',
        },
        7: {
          'time': '1:55',
          'ampm': 'PM',
        },
      };
    } else if (today.weekday == 2 || today.weekday == 5) {
      return {
        4: {
          'time': '9:00',
          'ampm': 'AM',
        },
        5: {
          'time': '11:35',
          'ampm': 'AM',
        },
        6: {
          'time': '1:55',
          'ampm': 'PM',
        },
      };
    } else if (today.weekday == 3) {
      return {
        1: {
          'time': '8:00',
          'ampm': 'AM',
        },
        2: {
          'time': '8:50',
          'ampm': 'AM',
        },
        3: {
          'time': '10:25',
          'ampm': 'AM',
        },
        4: {
          'time': '11:30',
          'ampm': 'AM',
        },
        5: {
          'time': '12:20',
          'ampm': 'PM',
        },
        6: {
          'time': '1:50',
          'ampm': 'PM',
        },
        7: {
          'time': '2:40',
          'ampm': 'PM',
        },
      };
    } else {
      return {};
    }
  }
}
