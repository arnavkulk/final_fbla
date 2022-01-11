import 'package:final_fbla/constants/app_constants.dart';
import 'package:final_fbla/utils/beam_locations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'utils/firebase_options.dart';
import 'package:beamer/beamer.dart';

// Runs the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

// Widget that encompasses the entire app, used to wrap the app with providers, navigation, state, etc.
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _routerDelegate = BeamerDelegate(
    notFoundRedirect: RootLocation(),
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        RootLocation(),
      ],
    ),
    initialPath: '/',
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp.router(
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
        debugShowCheckedModeBanner: false,
        title: AppConstants.title,
      ),
    );
  }
}
