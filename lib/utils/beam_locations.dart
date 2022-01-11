import 'package:beamer/beamer.dart';
import 'package:final_fbla/screens/root_screen.dart';
import 'package:flutter/material.dart';

// Root of the app, first location user enters no matter what
class RootLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    return [
      const BeamPage(
        key: ValueKey('root'),
        name: 'root',
        child: RootScreen(),
        title: 'name',
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/'];
}
