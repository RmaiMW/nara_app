import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara_app/views/home.dart';

import 'package:nara_app/Reg_and_logo/Registration.dart';
import 'package:nara_app/Reg_and_logo/SignInPage.dart';
import 'package:nara_app/main.dart';

import 'package:velocity_x/velocity_x.dart';



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
  double _currentSliderValue = 20;
  TabController _tabController;

  int _selectedIndex=0;
  void initState(){
    super.initState();
    _tabController = TabController(vsync:this ,length: 2);
  }
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }




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
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children:<Widget> [

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    child: Text("PROFILE",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.white)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children:<Widget> [
                      HStack( [
                        GestureDetector(
                          child: VxBox(child:"Username".text.red500.bold.makeCentered().p16()).red200.roundedLg.make(),
                          onTap: (){
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                          },
                        ),
                      ]),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar( maxRadius: 50,
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),

                  HStack( [
                    GestureDetector(
                      child: VxBox(child:Row(children:[Text("Saved",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold,/*fontSize: 24*/),), Icon(Icons.playlist_add,color: Colors.redAccent,),],).p16()).red200.roundedLg.make(),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                      },
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(left: 40,right: 20,bottom: 10,top: 10),
                    child: Container(//margin: EdgeInsets.only(top: 20,left: 1,right: 40,bottom: 20),
                        color: Colors.white,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Choose size of line\t',style: TextStyle(color: Colors.redAccent,fontWeight:FontWeight.bold),),Slider(activeColor:Colors.redAccent,value: _currentSliderValue,min: 20,max: 40,divisions: 5,label: _currentSliderValue.round().toString(), onChanged: (double s){ setState(() {
                          _currentSliderValue=s;
                        });})],)
                    ),
                  ),
                  HStack([
                    GestureDetector(
                      child: VxBox(child: "Change Password".text.bold.red500.makeCentered().p16()).red200.roundedLg.make(),
                      onTap: (){
                        _showMyDialog();
                      },
                    )
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HStack([
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: VxBox(child: "New Account".text.red500.bold.makeCentered().p16()).red200.roundedLg.make(),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
                            },

                          ),
                        ),],
                      ),

                      HStack([
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: VxBox(child: "Sign-in".text.red500.bold.makeCentered().p16()).red200.roundedLg.make(),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                            },
                          ),
                        ),],
                      ),

                    ],
                  ),
                  HStack([
                    GestureDetector(
                      child: VxBox(child: "Sign out".text.bold.red500.makeCentered().p16()).red200.roundedLg.make(),
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                      },
                    )
                  ]),

                ],
              ),
            ),
          ),
        ),


        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          unselectedFontSize: 14,
          selectedFontSize: 13,
          selectedItemColor:Colors.blueGrey,
          unselectedItemColor:Colors.redAccent,
          items: [
            BottomNavigationBarItem(icon:Icon(Icons.home),//_selectedIndex==0?Icon(Icons.home,color: Colors.blueGrey):Icon(Icons.home,color: Colors.redAccent,),
              label:'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Profile',),
          ],
          onTap: _onItemTapped,
        ),

      ),
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content:SingleChildScrollView(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container( margin:EdgeInsets.all(4), width: 200,height: 50,
                  child:TextField(obscureText: true, obscuringCharacter: '*',
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Current Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Container(margin:EdgeInsets.all(4), width: 200,height: 50,
                  child:TextField(obscureText: true, obscuringCharacter: '*',
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "New Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Container(margin:EdgeInsets.all(4), width: 200,height: 50,
                  child:TextField(obscureText: true, obscuringCharacter: '*',
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "re-enter NewPassword",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Apply',style: TextStyle(color: Colors.redAccent),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel',style: TextStyle(color: Colors.redAccent),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}