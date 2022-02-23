import 'package:beamer/src/beamer.dart';
import 'package:final_fbla/screens/activities.dart';
import 'package:final_fbla/screens/calendar.dart';
import 'package:final_fbla/screens/food.dart';
import 'package:final_fbla/screens/screens.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static int _selectedIndex = 0;
  static final Key _bottomNavBarKey = UniqueKey();
  static final routes = [
    HomeScreen.route,
    Calendar.route,
    Activities.route,
    Food.route,
  ];

  @override
  void initState() {
    super.initState();
  }

  static void setSelected(String route) {
    _selectedIndex = routes.indexOf(route);
  }

  static int get selected => _selectedIndex;
  static String get selectedRoute => routes[_selectedIndex];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: _bottomNavBarKey,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFFF0F0F0),
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
      currentIndex: _selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.insert_chart),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.done),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.calendar_today),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.chat_bubble),
        ),
      ],
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        context.beamToNamed(routes[index]);
      },
    );
  }
}
