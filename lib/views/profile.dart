
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nara_app/models/Nara.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/auth.dart';
import 'package:nara_app/services/database.dart';
import 'package:nara_app/services/storage.dart';
import 'package:nara_app/views/Saved.dart';
import 'package:nara_app/views/avatar.dart';
import 'package:nara_app/views/changetheme.dart';
import 'package:nara_app/views/home.dart';
import 'package:nara_app/views/loading.dart';

import 'package:nara_app/views/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'changename.dart';
import 'changepassword.dart';



void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Profile(),
    );
  }
}
class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  var _formKey = GlobalKey<FormState>();
  int _selectedIndex=0;
  bool loading = false;
  final AuthService _auth = AuthService();
  final StorageRepo _storageRepo=StorageRepo();
  bool isSwitched = false;

  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _repeatPasswordController = TextEditingController();
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
    //UserData userData=UserData();
    //chamge mame
    void showname() {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(''), content: SingleChildScrollView(
            child: ChangeName(),),
          );
        },
      );
    }
    //change password
    void showpass() {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(''), content: SingleChildScrollView(
            child: ChangePass(),),
          );
        },
      );
    }

    void changetheme() {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Change Theme'), content: SingleChildScrollView(
            child: ChangeTheme(),
          ),
          );
        },
      );
    }


    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            //print(userData.username);
            return Form(
              key: _formKey,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Profile'),
                  centerTitle: true,
                ),
                body: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,

                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child:Avatar(
                              avatarUrl: userData?.iconImage,
                              onTap: () async {
                                File image = await ImagePicker.pickImage(
                                    source: ImageSource.gallery);

                                await _storageRepo.uploadFile(image);
                                await DatabaseService(uid: user.uid).updateUserData(userData.username,userData.NewsUrl ,await _storageRepo.getUserProfileImage(user.uid));
                                    setState(() {});
                              },
                            ),
                            /* CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.blueAccent[100],
                              backgroundImage: AssetImage(
                                  'assets/avatar_male.png'),
                            ),
                            */
                          ),

                          HStack([
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Theme
                                      .of(context)
                                      .primaryColor,),
                                child: '${userData.username}'.text.bold
                                    .makeCentered().p16(),

                              ),
                              onTap: () => showname(),
                            ),
                          ]),
                          SizedBox(height: 20,),

                          HStack([
                            GestureDetector(
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),
                                    color: Theme
                                        .of(context)
                                        .primaryColor,),
                                  child: Row(children: [
                                    "Favorite".text.bold.makeCentered(),
                                    Icon(Icons.favorite),
                                  ],).p16()
                              ),
                              onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Later_saved(newsUrl: userData.NewsUrl)));
                              },
                            ),
                          ]),
                          SizedBox(height: 20,),
                          HStack([
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Theme
                                      .of(context)
                                      .primaryColor,),
                                child: "Change Theme".text.bold.makeCentered()
                                    .p16(),
                              ),
                              onTap: () => changetheme(),
                            ),
                          ]),
                          SizedBox(height: 20,),
                          HStack([
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Theme
                                      .of(context)
                                      .primaryColor,),
                                child: "Change Password".text.bold
                                    .makeCentered().p16(),
                              ),
                              onTap: () => Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangePass())),
                            )
                          ]),
                          SizedBox(height: 20),
                          HStack([
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Theme
                                      .of(context)
                                      .primaryColor,),
                                child: "Sign Out".text.bold.makeCentered()
                                    .p16(),
                              ),
                              onTap: () async {
                                await _auth.signout();

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (context) => Wrapper()));
                              },
                            )
                          ]),
                          //  FlatButton(onPressed: () async{ await _auth.signOut();}, child: Text('out')),

                        ],
                      ),
                    ),
                  ),
                ),


                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  unselectedFontSize: 14,
                  selectedFontSize: 13,
                  selectedItemColor: Colors.grey[700],
                  unselectedItemColor: Theme
                      .of(context)
                      .primaryColor,
                  items: [
                    BottomNavigationBarItem(icon: Icon(Icons.home),
                      //_selectedIndex==0?Icon(Icons.home,color: Colors.blueGrey):Icon(Icons.home,color: Colors.redAccent,),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle), label: 'Profile',),
                  ],
                  onTap: _onItemTapped,
                ),
              ),

            );
          }
          else {
            return Loading();
          }
        }

    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
      if (_selectedIndex == 0) Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      else Navigator.push(context,MaterialPageRoute(builder: (context)=>Profile()));
    });
  }

//change name

}