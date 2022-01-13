import 'package:final_fbla/constants/constants.dart';
import 'package:final_fbla/constants/style_constants.dart';
import 'package:flutter/material.dart';

// The first screen the user is taken to as soon as the open the app
class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Hello World',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
