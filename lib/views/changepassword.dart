import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nara_app/models/Nara.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/auth.dart';
import 'package:nara_app/services/database.dart';
import 'package:provider/provider.dart';

import 'loading.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {

  final _formkey = GlobalKey<FormState>();

  //String _password='';
  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _repeatPasswordController = TextEditingController();
  final AuthService _auth = AuthService();
  bool checkCurrentPasswordValid = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      Fluttertoast.showToast(
          msg: "No user found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pop();
      return null;
    }
    else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //  backgroundColor:Theme.of(context).primaryColor,// Colors.redAccent,
          elevation: 0.0,
          leading: Builder(builder: (context) {
            return IconButton(icon: Icon(Icons.menu, color: Theme
                .of(context)
                .primaryColor), onPressed: () {
              Scaffold.of(context).openDrawer();
            },);
          },),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text('NARA'),
              Text(
                ' News',
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
        body: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Change Your Password',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(4), width: 500, height: 80,
                child: TextFormField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        //     fillColor: Colors.white,
                        hintText: "Current Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)),)),
                    controller: _passwordController,
                    validator: (val) =>
                    val == ''
                        ? 'Empty Field! '
                        : null,
                    onChanged: (val) {
                      setState(() =>
                      _passwordController =
                      val as TextEditingController);
                    }

                ),
              ),
              TextFormField(obscureText: true,
                obscuringCharacter: '*',
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    //     fillColor: Colors.white,
                    hintText: "New Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)))),
                validator: (val) =>
                val.length < 6
                    ? 'Enter a password 6+ chars long'
                    : null,
                controller: _newPasswordController,
                onChanged: (val) {
                  setState(() =>
                  _newPasswordController =
                  val as TextEditingController);
                },
              ),

              SizedBox(height: 20,),
              TextFormField(obscureText: true,
                obscuringCharacter: '*',
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    //     fillColor: Colors.white,
                    hintText: "re-enter NewPassword",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)))),
                //  validator: (val) => val == _password ? np=true : 'Re-Enter the Password Pleasae!',
                controller: _repeatPasswordController,
                validator: (val) =>
                val == _newPasswordController.text
                    ? null
                    : 'Re-Enter the Password Pleasae!',
              ),

              Row(
                children: [
                  TextButton(
                    child: Text('Apply', style: TextStyle(color: Theme
                        .of(context)
                        .primaryColor),),
                    onPressed: () async {
                      checkCurrentPasswordValid =
                      await DatabaseService(uid: user.uid)
                          .validateCurrentPassword(
                          _passwordController.text);

                      setState(() {});

                      if (_formkey.currentState.validate() &&
                          checkCurrentPasswordValid) {
                        DatabaseService(uid: user.uid)
                            .updateUserPassword(
                            _newPasswordController.text);
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Successfully Changed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.blue,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                        Navigator.pop(context);
                      }


                      /*
                          if(_formkey.currentState.validate() &&
                              checkCurrentPasswordValid){
                            await DatabaseService(uid: user.uid).updateUserDatap(_newPasswordController.text);
                            Navigator.of(context).pop();
                          }

                           */


                    },
                  ),
                  TextButton(
                    child: Text('Cancel', style: TextStyle(color: Theme
                        .of(context)
                        .primaryColor),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
