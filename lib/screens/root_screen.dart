import 'package:beamer/src/beamer.dart';
import 'package:final_fbla/constants/constants.dart';
import 'package:final_fbla/constants/style_constants.dart';
import 'package:final_fbla/providers/auth_provider.dart';
import 'package:final_fbla/screens/screens.dart';
import 'package:final_fbla/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

// The first screen the user is taken to as soon as the open the app
class RootScreen extends StatelessWidget {
  static const String route = '/';
  bool _initialized = false;
  RootScreen({Key? key}) : super(key: key) {}

  void init(BuildContext context) {
    _initialized = true;
    AuthProvider provider = Provider.of<AuthProvider>(context, listen: false);
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      print(provider.user);
      if (provider.isAuthenticated) {
        print('authenticated');
        context.beamToNamed(HomeScreen.route);
      } else if (!provider.isLoggedIn) {
        print('not logged in');
        context.beamToNamed(Login.route);
      } else {
        print('verify');
        context.beamToNamed(VerifyEmail.route);
      }
    });
  }

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
        onPressed: () {
          init(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
