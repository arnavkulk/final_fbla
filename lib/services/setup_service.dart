import 'package:final_fbla/utils/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SetupService {
  static Future<void> setup() async {
    await dotenv.load(fileName: ".env");
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // await FirebaseFirestore.instance.enablePersistence();
  }
}
