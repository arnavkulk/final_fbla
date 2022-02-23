import 'package:beamer/beamer.dart';
import 'package:final_fbla/constants/constants.dart';
import 'package:final_fbla/screens/activities.dart';
import 'package:final_fbla/screens/add_class.dart';
import 'package:final_fbla/screens/calendar.dart';
import 'package:final_fbla/screens/food.dart';
import 'package:final_fbla/screens/home_screen.dart';
import 'package:final_fbla/screens/onboarding/forgot_password.dart';
import 'package:final_fbla/screens/onboarding/handle_verification.dart';
import 'package:final_fbla/screens/onboarding/login.dart';
import 'package:final_fbla/screens/onboarding/register.dart';
import 'package:final_fbla/screens/onboarding/verify_email.dart';
import 'package:final_fbla/screens/root_screen.dart';
import 'package:final_fbla/services/auth_service.dart';
import 'package:flutter/material.dart';

// Root of the app, first location user enters no matter what
class RootLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('root'),
        name: 'root',
        child: RootScreen(),
        title: AppConstants.title,
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [RootScreen.route];
}

class OnboardingLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    List<BeamPage> pagesStack = <BeamPage>[];
    List<String> location = state.uri.pathSegments;

    if (location.contains(Register.route.replaceAll("/", ""))) {
      SignInMethod method = SignInMethod.EMAIL_PASSWORD;
      print(super.data);
      if (super.data != null) {
        Map<String, dynamic> args = super.data as Map<String, dynamic>;
        if (args['method'] != null) {
          method = args['method'] as SignInMethod;
        }
      }
      pagesStack.add(
        BeamPage(
          key: const ValueKey(Register.route),
          name: Register.route,
          type: BeamPageType.noTransition,
          child: Register(
            method: method,
          ),
        ),
      );
    }

    if (location.contains(Login.route.replaceAll("/", ""))) {
      pagesStack.add(
        const BeamPage(
          key: ValueKey(Login.route),
          name: Login.route,
          type: BeamPageType.noTransition,
          child: Login(),
        ),
      );
    }

    if (location.contains(HandleVerification.route.replaceAll("/", ""))) {
      pagesStack.add(
        BeamPage(
          key: const ValueKey(HandleVerification.route),
          name: HandleVerification.route,
          type: BeamPageType.noTransition,
          child: HandleVerification(
            queryParams: state.queryParameters,
          ),
        ),
      );
    }

    if (location.contains(VerifyEmail.route.replaceAll("/", ""))) {
      pagesStack.add(
        const BeamPage(
          key: ValueKey(VerifyEmail.route),
          name: VerifyEmail.route,
          type: BeamPageType.noTransition,
          child: VerifyEmail(),
        ),
      );
    }

    if (location.contains(ForgotPassword.route.replaceAll("/", ""))) {
      pagesStack.add(
        const BeamPage(
          key: ValueKey(ForgotPassword.route),
          name: ForgotPassword.route,
          type: BeamPageType.noTransition,
          child: ForgotPassword(),
        ),
      );
    }

    return pagesStack;
  }

  @override
  List<Pattern> get pathPatterns => [
        Register.route,
        Login.route,
        HandleVerification.route,
        VerifyEmail.route,
        ForgotPassword.route,
      ];
}

class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    List<BeamPage> pagesStack = <BeamPage>[];
    List<String> location = state.uri.pathSegments;

    if (location.contains(HomeScreen.route.replaceAll("/", ""))) {
      pagesStack.add(
        const BeamPage(
          key: ValueKey(HomeScreen.route),
          name: HomeScreen.route,
          type: BeamPageType.noTransition,
          child: HomeScreen(),
        ),
      );
    }
    if (location.contains(Calendar.route.replaceAll("/", ""))) {
      pagesStack.add(
        const BeamPage(
          key: ValueKey(Calendar.route),
          name: Calendar.route,
          type: BeamPageType.noTransition,
          child: Calendar(),
        ),
      );
    }
    if (location.contains(Activities.route.replaceAll("/", ""))) {
      pagesStack.add(
        const BeamPage(
          key: ValueKey(Activities.route),
          name: Activities.route,
          type: BeamPageType.noTransition,
          child: Activities(),
        ),
      );
    }

    if (location.contains(AddClass.route.replaceAll("/", ""))) {
      pagesStack.add(
        const BeamPage(
          key: ValueKey(AddClass.route),
          name: AddClass.route,
          type: BeamPageType.noTransition,
          child: AddClass(),
        ),
      );
    }
    if (location.contains(Food.route.replaceAll("/", ""))) {
      pagesStack.add(
        const BeamPage(
          key: ValueKey(Food.route),
          name: Food.route,
          type: BeamPageType.noTransition,
          child: Food(),
        ),
      );
    }
    return pagesStack;
  }

  @override
  List<Pattern> get pathPatterns => [
        HomeScreen.route,
        Calendar.route,
        Activities.route,
        AddClass.route,
        Food.route,
      ];
}
