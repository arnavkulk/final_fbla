import 'dart:async';
import 'package:beamer/src/beamer.dart';
import 'package:final_fbla/providers/auth_provider.dart';
import 'package:final_fbla/screens/screens.dart';
import 'package:final_fbla/services/auth_service.dart';
import 'package:final_fbla/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyEmail extends StatefulWidget {
  static const String route = '/verifyEmail';

  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  String _buttonText = "Resend Email";
  bool _isLoading = false;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    // AuthService.currentUser?.sendEmailVerification();
    // Future(() async {
    //   _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
    //     await AuthService.currentUser?.reload();
    //     if (AuthService.currentUser?.emailVerified ?? false) {
    //       context.beamToNamed(HomeScreen.route);
    //     }
    //     timer.cancel();
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void refresh() async {
    await AuthService.currentUser?.reload();
    if (AuthService.currentUser?.emailVerified ?? false) {
      context.beamToNamed(HomeScreen.route);
    }
  }

  Future<void> sendVerificationEmail() async {
    setState(() {
      _buttonText = "Sending Email";
      _isLoading = true;
    });
    await AuthService.currentUser?.sendEmailVerification();
    setState(() {
      _buttonText = "Email Sent";
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: Transform.rotate(
                  angle: 38,
                  child: Image(
                    image: AssetImage('assets/email.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Verification",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    "A verification email has been sent to ${Provider.of<AuthProvider>(context).user!.email}. Please follow the instructions in the email to verify your account, then return to the app.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive an email?",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        if (_buttonText == "Sending Email") return;
                        sendVerificationEmail();
                      },
                      child: Text(
                        _buttonText,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 50,
              ),
              MaterialButton(
                elevation: 0,
                onPressed: () => refresh(),
                color: Colors.white,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                child: _isLoading
                    ? Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 3,
                          color: Colors.green.shade400,
                        ),
                      )
                    : Provider.of<AuthProvider>(context).emailVerified
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green.shade400,
                            size: 30,
                          )
                        : Text(
                            "Verify",
                            style: TextStyle(color: Colors.green.shade400),
                          ),
              ),
            ],
          )),
    ));
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
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Verify Email",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "An verification email has been sent to ${AuthService.currentUser!.email}. Follow the instructions in the email to verify your account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => sendVerificationEmail(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Refresh",
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Visibility(
                          child: CircularProgressIndicator(
                            color: Colors.green.shade700,
                            value: null,
                          ),
                          visible: _isLoading,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.all(15),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => refresh(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _buttonText,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Visibility(
                          child: CircularProgressIndicator(
                            color: Colors.green.shade700,
                            value: null,
                          ),
                          visible: _isLoading,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.all(15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
