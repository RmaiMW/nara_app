import 'package:flutter/material.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/database.dart';
import 'package:provider/provider.dart';

import 'loading.dart';

class ChangeName extends StatefulWidget {
  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {

  final _formkey=GlobalKey<FormState>();

  String _name;

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
                children: <Widget>[
                  Text(
                    'Change Your Name',
                    style: TextStyle(fontSize: 18.0,),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.username,
                    decoration: InputDecoration(
                        filled: true,
                    //    fillColor: Colors.white,
                        hintText: "Your Name",
                        enabled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),)),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _name= val),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      TextButton(
                        child: Text('Apply',style: TextStyle(color:Theme.of(context).primaryColor),),
                        onPressed: () async{
                          if(_formkey.currentState.validate()){
                            await DatabaseService(uid: user.uid).updateUserData(_name,userData.NewsUrl,userData.iconImage);
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      TextButton(
                        child: Text('Cancel',style: TextStyle(color:Theme.of(context).primaryColor),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),

               /*   RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formkey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                              _name ?? snapshot.data.username);
                          print(_name);
                          print(snapshot.data.username);
                          Navigator.pop(context);
                        }
                      }
                  ),*/
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
