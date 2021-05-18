import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nara_app/helper/data.dart';
import 'package:nara_app/helper/news.dart';
import 'package:nara_app/models/Nara.dart';
import 'package:nara_app/models/article_model.dart';
import 'package:nara_app/models/category_model.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/auth.dart';
import 'package:nara_app/services/database.dart';
import 'package:nara_app/services/storage.dart';
import 'package:nara_app/views/Saved.dart';
import 'package:nara_app/views/article_list.dart';
import 'package:nara_app/views/avatar.dart';
import 'package:nara_app/views/category_list.dart';
import 'package:nara_app/views/changename.dart';
import 'package:nara_app/views/changepassword.dart';
import 'package:nara_app/views/changetheme.dart';
import 'package:nara_app/views/home.dart';
import 'package:nara_app/views/wrapper.dart';
import 'package:provider/provider.dart';
import 'loading.dart';
import 'recommendation.dart';
import 'search.dart';


class HotNews extends StatefulWidget {
  @override
  _HotNewsState createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading = true;
  var _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final StorageRepo _storageRepo=StorageRepo();
  bool isSwitched = false;
  List _News = [];
  int _selectedIndex = 2;
  String category;


  bool _isVisible = false;

  void show() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    _News.clear();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getHotNews();
    articles = newsClass.news;
    setState(() {
      loading = false;
    });
  }
  _showname() {
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
  _changetheme() {
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


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamProvider<List<Nara>>.value(
      value: DatabaseService().Unara,
      child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              _News.addAll(userData.NewsUrl);
              category=userData.Category;

              return Form(
          key: _formKey,
          child: Scaffold(
            body: loading
                ? Loading()
                : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: <Widget>[
                    /// Blogs
                    ArticleList(
                      articles: articles,
                    ),
                  ],
                ),
              ),
            ),


          ),
        );
  }
            else{
              return Loading();
            }
}
      ),
    );
  }


  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
      if (_selectedIndex == 0)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      else if(_selectedIndex == 1)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Recomm(cat: category,)));

      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HotNews()));
      }
    });
  }
}


class CustomizeListTile extends StatelessWidget{

  IconData icon;
  String text;
  Function onTap;
  CustomizeListTile(this.icon,this.text,this.onTap);
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
        ),
        child: InkWell(
          splashColor: Colors.orangeAccent,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(padding: const EdgeInsets.all(8.0)),
                    Text(text,style: TextStyle(
                        fontSize: 16.0
                    ),),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


