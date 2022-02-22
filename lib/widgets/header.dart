import 'package:beamer/src/beamer.dart';
import 'package:final_fbla/screens/screens.dart';
import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class Header extends AppBar {
  Header(BuildContext context, String text, {List<Widget>? buttons})
      : super(
          title: Text(text),
          actions: <Widget>[
            buttons == null
                ? Container(
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        context.beamToNamed(HomeScreen.route);
                      },
                    ),
                  )
                : Row(
                    children: [
                      ...buttons,
                      ...(Navigator.canPop(context)
                          ? [
                              IconButton(
                                icon: Icon(Icons.arrow_back_sharp),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ]
                          : [])
                    ],
                  )
          ],
        );
}
