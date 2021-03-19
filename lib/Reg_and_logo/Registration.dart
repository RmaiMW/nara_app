import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CommonLogo.dart';
import 'SignInPage.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool checked = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
             //   colors: [const Color(0XFFF50057),const Color(0XFFF44336)],
                colors: [ Colors.redAccent,Colors.redAccent[100]],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomCenter,
                stops: [0.0,0.8],
                tileMode: TileMode.mirror
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CommonLogo(),
                  HeightBox(10),
                  "CREATE YOUR ACCOUNT".text.size(22).yellow100.make(),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Full Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "re-enter password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  HStack([
                    Checkbox(
                      value: checked, onChanged: (bool value) { checked=value ;},

                    ),
                    "Agree & Continue".text.make().py16()

                  ]),
                  HStack([
                    VxBox(child: "Cancel".text.white.makeCentered().p16()).red500.roundedLg.make().px16().py16(),
                    VxBox(child: "Register".text.white.makeCentered().p16()).red500.roundedLg.make().px16().py16(),
                  ]),
                  GestureDetector(
                    onTap: (){
                      print("Sign In");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                    },
                    child: HStack([
                      "Already Registered?".text.make(),
                      " Sign In".text.white.make()
                    ]).centered(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}