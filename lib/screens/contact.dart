import 'package:final_fbla/providers/user_provider.dart';
import 'package:final_fbla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';

class Contact extends StatefulWidget {
  static const String route = '/contact';
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _body, _subject, _recipient;

  @override
  void initState() {
    super.initState();
    _body = TextEditingController();
    _subject = TextEditingController();
    _recipient = TextEditingController();
  }

  @override
  void dispose() {
    _body.dispose();
    _subject.dispose();
    _recipient.dispose();
    super.dispose();
  }

  Future<void> sendEmail(BuildContext context) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final Email email = Email(
      body: _body.text,
      subject: _subject.text,
      recipients: [_recipient.text],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
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
                    "Contact a Teacher",
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
                        inputType: TextInputType.emailAddress,
                        hintText: "Recipient",
                        controller: _recipient,
                        validator: (String? val) {
                          val = _recipient.text;
                          if (val == null || val.isEmpty) {
                            return "Please enter the recipient email";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: FancyTextFormField(
                        hintText: "Subject",
                        controller: _subject,
                        validator: (String? val) {
                          val = _subject.text;
                          if (val == null || val.isEmpty) {
                            return "Please enter your password";
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
                        hintText: "Body",
                        controller: _body,
                        validator: (String? val) {
                          val = _body.text;
                          if (val == null || val.isEmpty) {
                            return "Please enter the message body";
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
