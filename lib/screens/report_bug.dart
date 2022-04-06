import 'package:final_fbla/providers/user_provider.dart';
import 'package:final_fbla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';

class ReportBug extends StatefulWidget {
  static const String route = '/reportbug';
  const ReportBug({Key? key}) : super(key: key);

  @override
  _ReportBugState createState() => _ReportBugState();
}

class _ReportBugState extends State<ReportBug> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _description, _bug;

  @override
  void initState() {
    super.initState();
    _description = TextEditingController();
    _bug = TextEditingController();
  }

  @override
  void dispose() {
    _description.dispose();
    _bug.dispose();
    super.dispose();
  }

  Future<void> sendEmail(BuildContext context) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final Email email = Email(
      body: _description.text,
      subject: _bug.text,
      recipients: ["arnavyk@gmail.com"],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      left: false,
      right: false,
      top: false,
      bottom: false,
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Report a Bug",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: FancyTextFormField(
                        hintText: "Bug",
                        controller: _bug,
                        validator: (String? val) {
                          val = _bug.text;
                          if (val == null || val.isEmpty) {
                            return "Please briefly summarize the bug";
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
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: FancyTextFormField(
                        hintText: "Description",
                        controller: _description,
                        validator: (String? val) {
                          val = _description.text;
                          if (val == null || val.isEmpty) {
                            return "Please enter the a detailed description of what the bug is.";
                          }
                          return null;
                        },
                        prefixIcon: Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: input validation and error handling
                  if (_formKey.currentState!.validate()) {
                    sendEmail(context);
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
                  "SEND",
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
    );
  }
}
