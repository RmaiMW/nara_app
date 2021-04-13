import 'package:flutter/material.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/database.dart';
import 'package:provider/provider.dart';

import 'loading.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {

  final _formkey=GlobalKey<FormState>();

  String _password='';



  @override
  Widget build(BuildContext context) {
    User user=Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;

            return Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Change Your Password',
                    style: TextStyle(fontSize: 18.0,),
                  ),
                  SizedBox(height: 20,),
                   TextFormField(obscureText: true, obscuringCharacter: '*',
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                       //   fillColor: Colors.white,
                          hintText: "New Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => _password = val);
                      },
                    ),

                  SizedBox(height: 20,),
                  TextFormField(obscureText: true, obscuringCharacter: '*',
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                     //     fillColor: Colors.white,
                          hintText: "re-enter NewPassword",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                    //  validator: (val) => val == _password ? np=true : 'Re-Enter the Password Pleasae!',
                      validator: (val) => val == _password ? null : 'Re-Enter the Password Pleasae!',
                    ),

                  Row(
                    children: [
                      TextButton(
                        child: Text('Apply',style: TextStyle(color: Theme.of(context).primaryColor),),
                        onPressed: () async{
                          if(_formkey.currentState.validate()){
                            await DatabaseService(uid: user.uid).updateUserDatap(_password);
                            Navigator.of(context).pop();
                          }

                        },
                      ),
                      TextButton(
                        child: Text('Cancel',style: TextStyle(color: Theme.of(context).primaryColor),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}
