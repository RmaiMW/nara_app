
import 'package:flutter/material.dart';
import 'package:nara_app/bloc/custom_theme.dart';
import 'package:nara_app/bloc/theme.dart';
import 'package:velocity_x/velocity_x.dart';

class ChangeTheme extends StatefulWidget {
  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {

  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
   //   Padding(
      //  padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
    //    child:
        child:  Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _changeTheme(context, MyThemeKeys.LIGHT);
                },
                child: Text("Light Theme"),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _changeTheme(context, MyThemeKeys.DARK);
                },
                child: Text("Dark Theme"),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _changeTheme(context, MyThemeKeys.DARKER);
                },
                child: Text("Darker Theme"),
              ),
              Row(
                children: [
                  TextButton(
                    child: Text('Close',style: TextStyle(color: Theme.of(context).primaryColor),),
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
