import 'package:flutter/material.dart';
import 'package:nara_app/views/home.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CommonLogo.dart';
import 'Registration.dart';
import 'package:nara_app/services/auth.dart';
import 'package:nara_app/views/loading.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
    return loading ? Loading() : SafeArea(
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
                  "Email Sign-IN".text.size(22).yellow100.make(),

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
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))
                    ),
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ).p4().px24(),

                  HStack([
                    Checkbox(
                      value: checked, onChanged: (bool value) { checked=value ;},

                    ),
                    "Remember Me".text.make().py16()

                  ]),
                  HStack([
                    RaisedButton(
                        color: Colors.red[500],
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                            if(result == null) {
                              setState(() {
                                loading = false;
                                error = 'Could not sign in with those credentials';
                              });
                            }
                          }
                        }
                    ),
                    GestureDetector(
                      child: VxBox(child: "Get Started".text.white.makeCentered().p16()).red500.roundedLg.make(),
                      onTap: (){
                        print("Sign In");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                      },


                    ),


                  ]),
                  GestureDetector(
                    onTap: (){
                      print("forgot Password");
                    },

                    child: HStack([
                      "Forgot Password?".text.white.makeCentered(),
                    ]).centered().p4(),
                  ),
                  HStack([
                    VxBox(child:  FaIcon(FontAwesomeIcons.facebookF,color: Colors.white,size: 30,).p20()).blue700.roundedFull.make(),
                    VxBox(child:  FaIcon(FontAwesomeIcons.google,color: Colors.white,size: 25,).p20()).red700.roundedFull.make().p4(),
                  ])
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
          },
          child: Container(
              height: 25,
              color: Colors.redAccent,
              child: Center(child: "Create a new Account..! Sign Up".text.white.makeCentered())),
        ),
      ),
    );
  }
}