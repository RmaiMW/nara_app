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
  String _currentpassword='';

  bool cp=false;
  bool np=false;

  @override
  Widget build(BuildContext context) {
    User user=Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            _currentpassword=userData.password;
            return Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Change Your Password',
                    style: TextStyle(fontSize: 18.0,color: Colors.redAccent),
                  ),
                  SizedBox(height: 20,),
                  Container( margin:EdgeInsets.all(4), width: 200,height: 50,
                    child:TextFormField(obscureText: true, obscuringCharacter: '*',
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Current Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),)),
                      onChanged: (val)=>val==_currentpassword?cp=true:"Current Password",
                    ),
                  ),
                  Container(margin:EdgeInsets.all(4), width: 200,height: 50,
                    child:TextFormField(obscureText: true, obscuringCharacter: '*',
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "New Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => _password = val);
                      },
                    ),
                  ),
                  Container(margin:EdgeInsets.all(4), width: 200,height: 50,
                    child:TextFormField(obscureText: true, obscuringCharacter: '*',
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "re-enter NewPassword",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                      validator: (val) => val == _password ? np=true : 'Re-Enter the Password Pleasae!',
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: Text('Apply',style: TextStyle(color: Colors.redAccent),),
                        onPressed: () async{
                          if(cp && np &&_formkey.currentState.validate()){
                            await DatabaseService(uid: user.uid).updateUserDatap(_password);
                            print(_password);
                            print(snapshot.data.password);
                          }
                          Navigator.of(context).pop();
                          print(snapshot.data.password);
                          print(cp);print(np);print(_password);print(_currentpassword);
                        },
                      ),
                      TextButton(
                        child: Text('Cancel',style: TextStyle(color: Colors.redAccent),),
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
