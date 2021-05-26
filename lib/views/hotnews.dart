import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara_app/helper/data.dart';
import 'package:nara_app/helper/news.dart';
import 'package:nara_app/models/Nara.dart';
import 'package:nara_app/models/article_model.dart';
import 'package:nara_app/models/category_model.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/auth.dart';
import 'package:nara_app/services/database.dart';
import 'package:nara_app/services/storage.dart';
import 'package:nara_app/views/article_list.dart';
import 'package:provider/provider.dart';
import 'loading.dart';



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

}



