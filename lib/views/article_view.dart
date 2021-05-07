import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'loading.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  ArticleView({this.blogUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final _formKey = GlobalKey<FormState>();
  String NewsUrl= null;
  //List _NewsUrl = [];
  List _NewsUrl = [];

  final Completer<WebViewController> _completer =
  Completer<WebViewController>();


  bool _fav =false;
  bool _like =false;
  bool _dis=false;
  bool flag = true;
  void favorite() {
    setState(() {
      _fav = !_fav;
    });
  }
  //instead of like and dislike a flash on the agency
  void like() {
    setState(() {
      _like = !_like;
      if(_like) _dis=false;
    });
  }
  void dis() {
    setState(() {
      _dis = !_dis;
      if(_dis) _like=false;
    });
  }
  void changeFontSize() async{
    setState(() {
    });
  }
  /*
  _addNewsUrl(String NewsUrl) async{
    if (Newsurl.isNotEmpty) {
      setState(() {

      //subingredientController.clear();
    }
  }

   */


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if(user == null){
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //   backgroundColor: Colors.redAccent,
          elevation: 0.0,

          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              //  crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [/*
                    FlatButton.icon(onPressed: () {},
                        icon: IconButton(icon: Icon(
                            _like ? Icons.thumb_up_alt : Icons
                                .thumb_up_alt_outlined,
                            color: Colors.white), onPressed: () {
                          like();
                        },),
                        label: Text('')),
                    FlatButton.icon(onPressed: () {},
                        icon: IconButton(icon: Icon(
                            _dis ? Icons.thumb_down_alt : Icons
                                .thumb_down_outlined,
                            color: Colors.white), onPressed: () {
                          dis();
                        },),
                        label: Text('')),
                  ],
                ),
                SizedBox(height: 40,),
                Row(crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FlatButton.icon(onPressed: () {},
                        icon: IconButton(icon: Icon(
                            _fav ? Icons.favorite : Icons
                                .favorite_border, color: Colors.white),
                          onPressed: () async {
                            favorite();
                          },),
                        label: Text('')),*/
                    FlatButton.icon(onPressed: () {},
                        icon: IconButton(icon: Icon(
                            _fav ? Icons.favorite : Icons
                                .favorite_border, color: Colors.white),
                          onPressed: () async {
                            favorite();
                          },),
                        label: Text('')),
                    FlatButton.icon(onPressed: () {},
                        icon: IconButton(icon: Icon(
                          Icons.public, color: Colors.white,),
                          onPressed: ()  {
                          },),
                        label: Text('')),
                  ],
                ),
              ],
            ),
          ),
        ),

        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: WebView(
            initialUrl: widget.blogUrl,
            onWebViewCreated: ((WebViewController webViewController) {
              _completer.complete(webViewController);
              //NewsUrl = widget.blogUrl;
            }),
          ),

        ),

      );

    }

    else{
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid:user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              _NewsUrl.addAll(userData.NewsUrl);
              //print(userData.NewsUrl.toList());
              //print(userData.username);
              return Form(
                key: _formKey,
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    // backgroundColor: Colors.redAccent,
                    elevation: 0.0,
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        //  crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[

                          SizedBox(height: 40,),
                          Row(crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FlatButton.icon(onPressed: () async {
                                //_addNewsUrl(NewsUrl);
                                //_NewsUrl.add(NewsUrl);
                              },
                                  icon: IconButton(icon: Icon(
                                      _fav ? Icons.favorite : Icons
                                          .favorite_border, color: Colors.white),
                                    onPressed: () async {
                                      favorite();
                                      if(_fav && (NewsUrl!=null)) {
                                        _NewsUrl.forEach((element) {
                                          if(element == NewsUrl){
                                            flag=false;
                                          }
                                          //flag = true;
                                        });
                                        if(flag && _fav) {
                                          _NewsUrl.add(NewsUrl);
                                          //userData.NewsUrl= _NewsUrl;
                                          await DatabaseService(uid: user.uid)
                                              .updateUserData(
                                              userData.username, _NewsUrl,
                                              userData.iconImage);
                                        }
                                        else{
                                          Fluttertoast.showToast(
                                              msg: "Its already in Saved List",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.TOP,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.black,
                                              fontSize: 16.0
                                          );

                                        }
                                        //print(_NewsUrl);
                                        //print(NewsUrl);
                                        //setState(() {});
                                      }
                                      else{
                                        print(NewsUrl);
                                      }
                                    },),
                                  label: Text('')),
                              FlatButton.icon(onPressed: () {},
                                  icon: IconButton(icon: Icon(
                                    Icons.public, color: Colors.white,),
                                    onPressed: () async {
                                      if (await canLaunch(NewsUrl)) {
                                        await launch(NewsUrl);
                                      } else {
                                        throw 'Could not launch $NewsUrl';
                                      }


                                    },),
                                  label: Text('')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  body:Center(
                    child:Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: WebView(
                        initialUrl: widget.blogUrl,
                        onWebViewCreated: ((WebViewController webViewController) async {
                          _completer.complete(webViewController);
                          NewsUrl = widget.blogUrl;
                          //setState(() {});
                        }),
                      ),

                    ),
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
  }
}