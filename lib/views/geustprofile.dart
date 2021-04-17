import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara_app/Reg_and_logo/Registration.dart';
import 'package:nara_app/Reg_and_logo/SignInPage.dart';
import 'package:nara_app/views/wrapper.dart';
import 'package:velocity_x/velocity_x.dart';
import 'geustHome.dart';

class geustProfile extends StatelessWidget {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            //   colors: [const Color(0XFFF50057),const Color(0XFFF44336)],
              colors: [ Colors.redAccent, Colors.redAccent[100]],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 0.8],
              tileMode: TileMode.mirror
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.blueAccent[100],
                    backgroundImage: AssetImage('assets/avatar_male.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 65, 20),
                  child: HStack([
                    SizedBox(width: 40,height: 20,),
                    GestureDetector(
                      child: VxBox(
                          child: "Sign In".text.bold.red600
                              .makeCentered().p16()).red200.roundedLg
                          .make(),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => Wrapper()));
                      },
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedFontSize: 14,
        selectedFontSize: 13,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.redAccent,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
            //_selectedIndex==0?Icon(Icons.home,color: Colors.blueGrey):Icon(Icons.home,color: Colors.redAccent,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'Profile',),
        ],
        onTap: (int index) {
          _selectedIndex = index;
          print(_selectedIndex);
          if (_selectedIndex == 0)
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => geustHome()));
          else
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => geustProfile()));
        },
      ),

    );
  }

}