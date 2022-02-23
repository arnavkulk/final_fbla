import 'package:final_fbla/models/class.dart';
import 'package:final_fbla/providers/class_provider.dart';
import 'package:final_fbla/utils/date_time.dart';
import 'package:final_fbla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  static const String route = '/calendar';
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = _selectedDate.add(Duration(days: 1));
  }

  List<Widget> buildTop() {
    List<Widget> ret = [];

    DateTime min =
        _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
    DateTime current = min;
    for (int i = 0; i < 7; i++) {
      ret.add(buildDateColumn(
          DateTime.fromMillisecondsSinceEpoch(current.millisecondsSinceEpoch)));
      current = current.add(Duration(days: 1));
    }
    return ret;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021, 8),
      lastDate: DateTime(2022, 7),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green.shade400,
            colorScheme: ColorScheme.light(primary: Colors.green.shade400),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    ClassProvider classProvider = Provider.of<ClassProvider>(context);
    var res = DateTimeUtils.periodToTimestamp(date: _selectedDate);
    List<Class> todaysClasses = classProvider.classes
        .where((classModel) => res.containsKey(classModel.period))
        .toList();
    return Screen(
      top: false,
      bottom: false,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            alignment: Alignment.topCenter,
            color: Colors.green.shade600,
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _selectDate(context),
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RichText(
                      text: TextSpan(
                          text: DateFormat.MMM().format(_selectedDate),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          children: [
                            TextSpan(
                              text: " ${_selectedDate.year}",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = DateTime.now();
                    });
                  },
                  child: Text(
                    "Today",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              height: MediaQuery.of(context).size.height - 160,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 30),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: buildTop(),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: todaysClasses.isEmpty
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          if (todaysClasses.isEmpty)
                            Container(
                              child: Text("No School!"),
                            ),
                          ...todaysClasses.map((c) => buildTaskListItem(c))
                        ],
                      ),
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

  Container buildTaskListItem(Class classModel) {
    var res = DateTimeUtils.periodToTimestamp(date: _selectedDate);
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 15,
                height: 10,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(5),
                    )),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: res[classModel.period]?["time"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: " ${res[classModel.period]?["ampm"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            )
                          ]),
                    ),
                    Text(
                      _selectedDate.weekday == 3 ? "1 hour" : "1h 30 min",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 185,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.only(right: 10, left: 30),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classModel.subject,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green.shade600,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      radius: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      classModel.teacherName,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green.shade600,
                      child: Center(
                        child: Icon(
                          Icons.location_on,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      radius: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      classModel.room.name,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildDateColumn(
    DateTime date,
  ) {
    bool isActive = date.day == _selectedDate.day;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = date;
        });
      },
      child: Container(
        decoration: isActive
            ? BoxDecoration(
                color: Colors.green.shade800,
                borderRadius: BorderRadius.circular(10))
            : BoxDecoration(),
        height: 55,
        width: 35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              DateFormat.E().format(date)[0],
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
            Text(
              date.day.toString(),
              style: TextStyle(
                  color: isActive ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
