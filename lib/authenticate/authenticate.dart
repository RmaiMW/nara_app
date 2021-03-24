import 'package:flutter/material.dart';
import 'package:nara_app/Reg_and_logo/Registration.dart';
import 'package:nara_app/Reg_and_logo/SignInPage.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInPage(toggleView:  toggleView);
    } else {
      return Registration(toggleView:  toggleView);
    }
  }
}