import 'package:beamer/src/beamer.dart';
import 'package:final_fbla/constants/constants.dart';
import 'package:final_fbla/constants/style_constants.dart';
import 'package:final_fbla/models/class.dart';
import 'package:final_fbla/providers/auth_provider.dart';
import 'package:final_fbla/providers/class_provider.dart';
import 'package:final_fbla/providers/user_provider.dart';
import 'package:final_fbla/screens/add_class.dart';
import 'package:final_fbla/screens/screens.dart';
import 'package:final_fbla/utils/date_time.dart';
import 'package:final_fbla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// The first screen the user is taken to as soon as the open the app
class HomeScreen extends StatelessWidget {
  static const String route = '/home';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ClassProvider classProvider = Provider.of<ClassProvider>(context);
    var res = DateTimeUtils.periodToTimestamp();
    List<Class> todaysClasses = classProvider.classes
        .where((classModel) => res.containsKey(classModel.period))
        .toList();
    return Screen(
      top: false,
      bottom: false,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                //color: Color(0xFFD4E7FE),
                gradient: LinearGradient(
                    colors: [
                      Colors.green.shade400,
                      Colors.green.shade800,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.6, 0.3])),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 90),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                        text: DateFormat.E().format(DateTime.now()),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900),
                        children: [
                          TextSpan(
                            text:
                                " ${DateTime.now().day} ${DateFormat.MMM().format(DateTime.now())}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.2),
                            blurRadius: 12,
                            spreadRadius: 8,
                          )
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi ${userProvider.user?.firstName}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "This is your day today",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 250,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height - 245,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView(
                children: [
                  buildTitleRow("TODAY's CLASSES ", todaysClasses.length,
                      () => context.beamToNamed(AddClass.route)),
                  SizedBox(
                    height: 20,
                  ),
                  if (classProvider.classes.isEmpty)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      child: Center(
                        child: Text(
                          "No classes today!",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ...todaysClasses
                      .map((classModel) => buildClassItem(context, classModel))
                      .toList(),
                  SizedBox(
                    height: 25,
                  ),
                  buildTitleRow("YOUR TASKS", 4, () {}),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        buildTaskItem(
                            3, "The Basic of Typography II", Colors.red),
                        buildTaskItem(3, "Design Psychology: Principle of...",
                            Colors.green),
                        buildTaskItem(3, "Design Psychology: Principle of...",
                            Colors.green),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildTaskItem(int numDays, String courseTitle, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(12),
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deadline",
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "$numDays days left",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 100,
            child: Text(
              courseTitle,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildTitleRow(String title, int number, void Function() add) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
                text: title,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
                children: [
                  TextSpan(
                    text: "($number)",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]),
          ),
          IconButton(
            onPressed: add,
            icon: Icon(
              Icons.add_circle_outlined,
              color: Colors.green.shade600,
            ),
          )
        ],
      ),
    );
  }

  Container buildClassItem(BuildContext context, Class classData) {
    var res = DateTimeUtils.periodToTimestamp();
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                res[classData.period]?["time"] ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.grey.shade700,
                    fontSize: 13),
              ),
              Text(
                res[classData.period]?["ampm"] ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Container(
            height: 100,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 160,
                child: Text(
                  classData.subject,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      classData.room.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green.shade600,
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 17,
                        color: Colors.white,
                      ),
                    ),
                    radius: 10,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    classData.teacherName,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
