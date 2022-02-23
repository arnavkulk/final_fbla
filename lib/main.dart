import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/constants/app_constants.dart';
import 'package:final_fbla/providers/class_provider.dart';
import 'package:final_fbla/providers/providers.dart';
import 'package:final_fbla/providers/user_provider.dart';
import 'package:final_fbla/screens/onboarding/handle_verification.dart';
import 'package:final_fbla/screens/onboarding/verify_email.dart';
import 'package:final_fbla/services/auth_service.dart';
import 'package:final_fbla/services/class_service.dart';
import 'package:final_fbla/services/setup_service.dart';
import 'package:final_fbla/utils/beam_locations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'models/class.dart';
import 'models/user_model.dart';
import 'utils/firebase_options.dart';
import 'package:beamer/beamer.dart';

// Runs the app
void main() async {
  await SetupService.setup();
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
        OnboardingLocation(),
        HomeLocation(),
      ],
    ),
    guards: [
      // BeamGuard(
      //   pathPatterns: [
      //     VerifyEmail.route,
      //     HandleVerification.route,
      //   ],
      //   check: (
      //     context,
      //     location,
      //   ) =>
      //       Provider.of<AuthProvider>(context).isLoggedIn,
      // ),
      // BeamGuard(
      //   pathPatterns: [/*TODO*/],
      //   check: (
      //     context,
      //     location,
      //   ) =>
      //       Provider.of<AuthProvider>(context).isAuthenticated,
      // ),
    ],
    initialPath: '/',
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (_) => UserProvider(),
          update: (BuildContext context, AuthProvider authProvider,
              UserProvider? userProvider) {
            if (userProvider == null) {
              return UserProvider();
            }
            if (authProvider.isLoggedIn) {
              return userProvider..loadUser();
            } else {
              return userProvider..clear();
            }
          },
        ),
        ChangeNotifierProxyProvider<UserProvider, ClassProvider>(
          create: (context) => ClassProvider(),
          update: (BuildContext context, UserProvider userProvider,
              ClassProvider? classProvider) {
            if (classProvider == null) {
              return ClassProvider();
            }
            List<String> classIds = userProvider.user?.classIds ?? [];

            if (!ListEquality().equals(
                classIds, classProvider.classes.map((e) => e.id).toList())) {
              return classProvider..loadClasses(classIds);
            }
            return classProvider;
          },
        )
      ],
      child: MaterialApp.router(
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
        debugShowCheckedModeBanner: false,
        title: AppConstants.title,
      ),
    );
  }
}
