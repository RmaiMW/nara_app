import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara_app/views/home.dart';
import 'package:nara_app/views/hotnews.dart';
import 'package:nara_app/views/recommendation.dart';
enum NavBarItem { HOME, RECOMM, HOTNEWS }

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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Recomm()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HotNews()));
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}