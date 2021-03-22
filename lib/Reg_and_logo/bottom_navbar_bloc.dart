import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara_app/views/profile.dart';
import 'package:nara_app/views/home.dart';

enum NavBarItem { HOME, PROFILE, }

class BottomNavBarBloc {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.HOME;
  BuildContext context;
  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}