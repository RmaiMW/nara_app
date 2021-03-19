import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara_app/views/home.dart';

import 'Reg_and_logo/Registration.dart';
import 'Reg_and_logo/SignInPage.dart';
import 'main.dart';


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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Profile'),
      ),

       body:SingleChildScrollView(
      child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         mainAxisSize: MainAxisSize.max,
         children:<Widget> [
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
             children:<Widget> [
              Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(padding: EdgeInsets.all(4),
              color: Colors.white,
                 child: FlatButton(
                   color: Colors.white,onPressed: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Registration()));}, child: Text('New Account',style: TextStyle(color: Colors.blueGrey),),
           ),

         ),
       ),
            Padding(
                     padding: const EdgeInsets.all(8.0),
                   child: Container(padding: EdgeInsets.all(4),
                 color: Colors.white,
                   child: FlatButton(
                  color: Colors.white,onPressed: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInPage()));}, child: Text('Sign-in',style: TextStyle(color: Colors.blueGrey),),
          ),
        ),
      ),
               CircleAvatar( maxRadius: 50,
               backgroundColor: Colors.blueGrey,
               ),


             ],
           ),

           Container(margin: EdgeInsets.only(top: 15,left: 1,right: 300),
             color: Colors.white,
             child: FlatButton(
                 color: Colors.white,onPressed: (){}, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Username\t',style: TextStyle(color: Colors.blueGrey),),],)),
           ),
             Container(margin: EdgeInsets.only(top: 30,left: 1,right: 300),
               color: Colors.white,
               child: FlatButton(
                 color: Colors.white,onPressed: (){}, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Saved\t',style: TextStyle(color: Colors.blueGrey),),Icon(Icons.playlist_add,color: Colors.blueGrey,)],)),
               ),
           Container(margin: EdgeInsets.only(top: 20,left: 1,right: 40,bottom: 20),
             color: Colors.white,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Choose size of line\t',style: TextStyle(color: Colors.blueGrey,fontWeight:FontWeight.bold),),Slider(activeColor:Colors.blueGrey,value: _currentSliderValue,min: 20,max: 40,divisions: 5,label: _currentSliderValue.round().toString(), onChanged: (double s){ setState(() {
              _currentSliderValue=s;
            });})],)
           ),
           Container(margin: EdgeInsets.only(top: 5,left: 1,right: 250),
             color: Colors.white,
             child: FlatButton(
                 color: Colors.white,onPressed: (){_showMyDialog();}, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Change Password\t',style: TextStyle(color: Colors.blueGrey),),],)),
           ),

             Padding(
               padding: const EdgeInsets.all(4.0),
               child: Container(padding: EdgeInsets.all(4),
                 color: Colors.white,
                 child: FlatButton(
                   color: Colors.white,onPressed: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));}, child: Text('Sign out',style: TextStyle(color: Colors.blueGrey),),
                 ),
               ),
             ),
         ],
       ),
       ),

       bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon:IconButton(icon:Icon(Icons.home_rounded,color: Colors.blueGrey,), onPressed: () { Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home())); },) ,
            label: 'Home',
            //title: Text('Home',style: TextStyle(color: Colors.blueGrey),)
          ),
          BottomNavigationBarItem(icon:IconButton(icon:Icon(Icons.account_circle,color: Colors.blueGrey,), onPressed: () { Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Profile())); },) ,
            label: 'Profile',
          ),
        ],
         fixedColor: Colors.blueGrey,
     ),

    );
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
              child: Text('Apply',style: TextStyle(color: Colors.blueGrey),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel',style: TextStyle(color: Colors.blueGrey),),
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


