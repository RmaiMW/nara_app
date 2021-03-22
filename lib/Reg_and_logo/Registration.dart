import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'CommonLogo.dart';
import 'SignInPage.dart';
import 'package:nara_app/services/auth.dart';
import 'package:nara_app/views/loading.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool checked = true;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): SafeArea(
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
                key: _formKey,
                children: <Widget>[
                  CommonLogo(),
                  HeightBox(10),
                  "CREATE YOUR ACCOUNT".text.size(22).yellow100.make(),

                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))
                    ),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },

                  ).p4().px24(),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))
                    ),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ).p4().px24(),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "re-enter password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))
                    ),
                      obscureText: true,
                      validator: (val) => val == password ? 'Re-Enter the Password Pleasae!' : null,
                  ).p4().px24(),
                  HStack([
                    Checkbox(
                      value: checked, onChanged: (bool value) { checked=value ;},

                    ),
                    "Agree & Continue".text.make().py16()

                  ]),
                  HStack([
                    VxBox(child: "Cancel".text.white.makeCentered().p16()).red500.roundedLg.make().px16().py16(),
                    RaisedButton(
                        color: Colors.red[500],
                        shape: RoundedRectangleBorder(),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          print(password);
                          print(email);
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            print(result);
                            if(result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              }
                              );
                            }
                            return Registration();
                          }
                        }
                    ).px16().py16(),
                    VxBox(
                      child: "Register".text.white.makeCentered().p16(),
                    ).red500.roundedLg.make().px16().py16(),
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
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
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