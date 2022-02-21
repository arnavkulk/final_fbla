import 'package:final_fbla/constants/constants.dart';
import 'package:final_fbla/constants/style_constants.dart';
import 'package:flutter/material.dart';

// The first screen the user is taken to as soon as the open the app
class HomeScreen extends StatelessWidget {
  static const String route = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!StyleConstants.initialized) {
      StyleConstants().init(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.title),
      ),
      body: Center(
        child: Container(
          child: Text("Home"),
        ),
      ),
    );
  }
}
