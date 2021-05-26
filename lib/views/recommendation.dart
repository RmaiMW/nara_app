import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara_app/helper/data.dart';
import 'package:nara_app/helper/news.dart';
import 'package:nara_app/models/Nara.dart';
import 'package:nara_app/models/article_model.dart';
import 'package:nara_app/models/category_model.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/database.dart';
import 'package:nara_app/views/article_list.dart';
import 'package:nara_app/views/recom_cat_list.dart';
import 'package:provider/provider.dart';
import 'loading.dart';



class Recomm extends StatefulWidget {
  final String cat;
  Recomm({this.cat});
  @override
  _RecommState createState() => _RecommState();
}

class _RecommState extends State<Recomm> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading = true;
  var _formKey = GlobalKey<FormState>();

  String category;
  String temp_cat;
  bool isSwitched = false;
  List _News = [];


  @override
  void initState() {
    temp_cat=widget.cat;
    super.initState();
    categories = getCategories();
    _News.clear();
    //print(category);
    getNews(temp_cat);
  }

  getNews(String cat) async {
    News newsClass = News();
    await newsClass.getRecomNews(cat);
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
              category = userData.Category;
              print(category);
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
                          category=='' ?
                            FavCategoryList(
                              categories: categories,
                            ):
                          /// Blogs
                          ArticleList(
                            articles: articles,
                          ),
                        ],
                      ),
                    ),
                  ),
                  floatingActionButton: Builder(builder: (BuildContext context){
                    return FloatingActionButton(onPressed: () async {
                      await DatabaseService(uid: user.uid).updateUserData(userData.username,userData.NewsUrl ,userData.iconImage,'');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Recomm(
                                cat: userData.Category,
                                //category: categoryName.toLowerCase(),
                              ),
                        ),
                      );
                    },
                    child: Icon(Icons.more_vert),

                    );
                  }),

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



