import 'package:final_fbla/widgets/header.dart';
import 'package:final_fbla/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_bar.dart';

// ignore: must_be_immutable
class Screen extends StatelessWidget {
  Widget child;
  Widget? floatingActionButton;
  String? title;
  List<Widget>? headerButtons;
  bool includeHeader, includeBottomNav;
  bool left, right, top, bottom;

  Color? color;
  static NavDrawer drawer = NavDrawer();
  static BottomNavBar bottomNavBar = BottomNavBar();

  Screen({
    Key? key,
    required this.child,
    this.title,
    this.headerButtons,
    this.includeHeader = false,
    this.includeBottomNav = true,
    this.left = true,
    this.right = true,
    this.top = true,
    this.bottom = true,
    this.floatingActionButton,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: includeHeader
          ? Header(
              context,
              title ?? "",
              buttons: headerButtons ?? [],
            )
          : null,
      body: Container(
        color: this.color ?? Theme.of(context).canvasColor,
        child: SafeArea(
          bottom: bottom,
          top: top,
          left: left,
          right: right,
          child: Container(
            child: child,
            key: key,
          ),
        ),
      ),
      // drawer: drawer,
      bottomNavigationBar: includeBottomNav ? bottomNavBar : null,
      resizeToAvoidBottomInset: false,
    );
  }
}
