import 'package:final_fbla/models/user_model.dart';
import 'package:final_fbla/models/usertype.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  static const List<Map<String, dynamic>> routes = [];
  int _selectedIndex = 0;

  NavDrawer({Key? key}) : super(key: key);

  void setSelected(String route) {
    _selectedIndex = routes.indexWhere((element) => element['route'] == route);
  }

  void navigate(BuildContext context, String route) {
    setSelected(route);

    Navigator.of(context).pushNamed(route);
  }

  int get selected => _selectedIndex;
  String get selectedRoute => routes[_selectedIndex]['route'];

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);

    List<NavItem> items = [];
    for (int i = 0; i < routes.length; i++) {
      Map<String, dynamic> curr = routes.elementAt(i);
      items.add(NavItem(
        _selectedIndex == i,
        curr['name'],
        curr['icon'],
        () {
          navigate(context, curr['route']);
        },
      ));
    }
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            // GestureDetector(
            //   onTap: () => Navigator.of(context).pushNamed(Profile.route),
            //   child: DrawerHeader(
            //     padding: EdgeInsets.only(left: 30, top: 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Container(
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: Colors.white,
            //           ),
            //           padding: EdgeInsets.all(10),
            //           width: 100,
            //           height: 100,
            //           child: Image.network(
            //             AuthService.currentUser?.photoURL ??
            //                 'https://firebasestorage.googleapis.com/v0/b/mustangapp-b1398.appspot.com/o/logo.png?alt=media&token=f45e368d-3cba-4d67-b8d5-2e554f87e046',
            //           ),
            //         ),
            //         Container(
            //           padding: EdgeInsets.only(top: 10, left: 10),
            //           child: Text(
            //             "${user.firstName} ${user.lastName}",
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 15,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //     decoration: BoxDecoration(
            //       color: Colors.green,
            //     ),
            //   ),
            // ),
            ...items,
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final bool _selected;
  final String _text;
  final IconData _leading;

  final void Function() _onTap;
  NavItem(
    this._selected,
    this._text,
    this._leading,
    this._onTap,
  );
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.green,
      onTap: () {},
      child: ListTile(
        leading: Icon(
          _leading,
          color: _selected ? Colors.white : Colors.green,
        ),
        title: Text(
          _text,
          style: TextStyle(
            color: _selected ? Colors.white : Colors.green,
          ),
        ),
        tileColor: _selected ? Colors.green : Colors.white,
        onTap: () {
          _onTap();
        },
      ),
    );
  }
}
