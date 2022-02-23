import 'package:beamer/src/beamer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_fbla/models/class.dart';
import 'package:final_fbla/models/room.dart';
import 'package:final_fbla/providers/user_provider.dart';
import 'package:final_fbla/services/class_service.dart';
import 'package:final_fbla/services/user_service.dart';
import 'package:final_fbla/widgets/fancy_text_form_field.dart';
import 'package:final_fbla/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddClass extends StatefulWidget {
  static const String route = '/addClass';
  const AddClass({Key? key}) : super(key: key);

  @override
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  late TextEditingController _subject,
      _teacherName,
      _description,
      _period,
      _building,
      _roomNumber;
  bool _created = false;

  @override
  void initState() {
    super.initState();
    _subject = TextEditingController();
    _teacherName = TextEditingController();
    _description = TextEditingController();
    _period = TextEditingController();
    _building = TextEditingController();
    _roomNumber = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _subject.dispose();
    _teacherName.dispose();
    _period.dispose();
    _description.dispose();
    _building.dispose();
    _roomNumber.dispose();
  }

  Future<void> createClass(BuildContext context) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
      String id = await ClassService.createClass(
        Class(
          id: "",
          subject: _subject.text,
          description: _description.text,
          teacherName: _teacherName.text,
          period: int.parse(_period.text),
          room: Room(
            id: "",
            geoPoint: GeoPoint(0, 0),
            building: _building.text,
            number: int.parse(_roomNumber.text),
          ),
          studentIds: [
            userProvider.user!.id,
          ],
          gradeLevels: [],
          capacity: 40,
          teacherId: "",
        ),
      );
      await UserService.addClass(userProvider.user!.uid, id);
      setState(() {
        _created = true;
      });
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      left: false,
      right: false,
      top: false,
      bottom: false,
      includeHeader: false,
      includeBottomNav: false,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade400,
              Colors.green.shade800,
            ],
          ),
        ),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _created
                ? [
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                            size: 200,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "Your class has been added!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            child: ElevatedButton(
                              child: Text(
                                "Continue",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontSize: 20,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.all(15),
                              ),
                              onPressed: () => context.beamBack(),
                            ),
                          )
                        ],
                      ),
                    )
                  ]
                : [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add a New Class",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: FancyTextFormField(
                                hintText: "Subject",
                                controller: _subject,
                                validator: (String? val) {
                                  val = _subject.text;
                                  if (val == null || val.isEmpty) {
                                    return "Please enter your class subject";
                                  }

                                  return null;
                                },
                                prefixIcon: Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: FancyTextFormField(
                                hintText: "Description",
                                controller: _description,
                                validator: (String? val) {
                                  val = _description.text;

                                  if (val == null || val.isEmpty) {
                                    return "Please enter your class description";
                                  }
                                  return null;
                                },
                                prefixIcon: Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: FancyTextFormField(
                                hintText: "Teacher Name",
                                controller: _teacherName,
                                validator: (String? val) {
                                  val = _teacherName.text;

                                  if (val == null || val.isEmpty) {
                                    return "Please enter the class teacher's name";
                                  }
                                  return null;
                                },
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: FancyTextFormField(
                                hintText: "Period",
                                controller: _period,
                                validator: (String? val) {
                                  val = _period.text;
                                  if (val == null || val.isEmpty) {
                                    return "Please enter your period number";
                                  }
                                  return null;
                                },
                                prefixIcon: Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: FancyTextFormField(
                                hintText: "Building",
                                controller: _building,
                                validator: (String? val) {
                                  val = _building.text;
                                  if (val == null || val.isEmpty) {
                                    return "Please enter the building number";
                                  }
                                  return null;
                                },
                                prefixIcon: Icon(
                                  FontAwesomeIcons.globeAmericas,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: FancyTextFormField(
                                hintText: "Room Number",
                                controller: _roomNumber,
                                validator: (String? val) {
                                  val = _roomNumber.text;
                                  if (val == null || val.isEmpty) {
                                    return "Please enter the room number";
                                  }
                                  return null;
                                },
                                prefixIcon: Icon(
                                  FontAwesomeIcons.globeAmericas,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    createClass(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.all(15),
                                  elevation: 5,
                                ),
                                child: Text(
                                  "ADD CLASS",
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
