import 'package:firebase_auth/firebase_auth.dart';
import 'package:nara_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:nara_app/views/Entraance.dart';
import 'package:nara_app/views/geustHome.dart';
import 'home.dart';
import 'package:nara_app/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  bool anonymous = false;
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    // return either the Home or Authenticate widget

    if (user == null){
      return Authenticate();
    } else{
      return Home();
    }

  }
}