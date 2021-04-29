import  'package:flutter/material.dart';
import 'package:nara_app/views/geustHome.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CommonLogo.dart';
import 'Registration.dart';
import 'package:nara_app/services/auth.dart';
import 'package:nara_app/views/loading.dart';

import 'ResetScreen.dart';

class SignInPage extends StatefulWidget {

  final Function toggleView;
  SignInPage({ this.toggleView });
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
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
          child:Form(
            key: _formKey,
           child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CommonLogo(),
                  HeightBox(10),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))
                    ),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val as TextEditingController);
                    },
                  ).p4().px24(),
                  TextFormField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))
                    ),
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => password = val as TextEditingController);
                    },
                  ).p4().px24(),

                  HStack([
                      Container(
                          child: Row(
                              children: <Widget>[
                              Text('Does not have account? Sign in as a '),
                              FlatButton(
                              textColor: Colors.blue,
                                child: Text('Guest', style: TextStyle(fontSize: 20),),
                                  onPressed: () {
                                        setState(() => loading = true);
                                        Navigator.push(context, MaterialPageRoute(builder: (
                                            context) => geustHome()));
                                        }
                                 ),
                      ]),
           ),

                  ]),
                  HStack([
                     RaisedButton(
                            color: Colors.red[500],
                            child: VxBox(child: "Get Started".text.white.makeCentered().p16()).make(),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                setState(() => loading = true);
                                dynamic result = await _auth.signInWithEmailAndPassword(email.text, password.text);
                                if(result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'The E-mail you entered or Password are invalid! ';
                                  });
                                }

                              }
                            }
                    ),

                  ]),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ResetScreen()));
                    },

                    child: HStack([
                      "Forgot Password?".text.white.makeCentered(),
                    ]).centered().p4(),
                  ),
                  HStack([
                    /*
                    VxBox(child:  FaIcon(FontAwesomeIcons.facebookF,color: Colors.white,size: 30,).p20()).blue700.roundedFull.make().onFeedBackTap(() {
                      _auth.signInFacebook();
                    }),

                     */
                    
                    VxBox(child:  FaIcon(FontAwesomeIcons.google,color: Colors.white,size: 25,).p20()).red700.roundedFull.make().p4().onTap(() {_auth.signInWithGoogle();}),
                  ]),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),

                ],
              ),
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
  Future submitAnon() async {
    await _auth.signInAnon();
    //Navigator.push(
    //  context,
    //  MaterialPageRoute(
     //   builder: (context) => Wrapper(),
     // ),
    //);
  }
}