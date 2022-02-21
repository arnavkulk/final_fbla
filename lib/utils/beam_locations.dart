import 'package:beamer/beamer.dart';
import 'package:final_fbla/constants/constants.dart';
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
      const BeamPage(
        key: ValueKey(RootScreen.route),
        name: RootScreen.route,
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
    if (state.routeInformation.location == null) {
      return [];
    }
    String location = state.routeInformation.location!;
    if (location.contains(Register.route)) {
      Map<String, dynamic> args = super.data as Map<String, dynamic>;
      pagesStack.add(
        BeamPage(
          key: const ValueKey(Register.route),
          name: Register.route,
          type: BeamPageType.noTransition,
          child: Register(
            method: args['method'] as SignInMethod,
          ),
        ),
      );
    }

    if (location.contains(Login.route)) {
      pagesStack.add(
        BeamPage(
          key: const ValueKey(Login.route),
          name: Login.route,
          type: BeamPageType.noTransition,
          child: Login(),
        ),
      );
    }

    if (location.contains(Login.route)) {
      pagesStack.add(
        BeamPage(
          key: const ValueKey(Login.route),
          name: Login.route,
          type: BeamPageType.noTransition,
          child: Login(),
        ),
      );
    }

    if (location.contains(HandleVerification.route)) {
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

    if (location.contains(VerifyEmail.route)) {
      pagesStack.add(
        const BeamPage(
          key: ValueKey(VerifyEmail.route),
          name: VerifyEmail.route,
          type: BeamPageType.noTransition,
          child: VerifyEmail(),
        ),
      );
    }

    if (location.contains(ForgotPassword.route)) {
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
    return [
      const BeamPage(
        key: ValueKey(HomeScreen.route),
        name: HomeScreen.route,
        child: HomeScreen(),
        title: AppConstants.title,
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [HomeScreen.route];
}
