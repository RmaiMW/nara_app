import 'package:flutter/material.dart';
import 'package:nara_app/helper/news.dart';
import 'package:nara_app/models/Nara.dart';
import 'package:nara_app/models/article_model.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/database.dart';
import 'package:nara_app/views/article_list.dart';
import 'package:nara_app/views/article_saved_list.dart';
import 'package:provider/provider.dart';
import 'loading.dart';
import 'search.dart';

class Later_saved extends StatefulWidget {
  final String newsUrl;
  Later_saved({Key key, @required this.newsUrl}) : super(key: key);

  @override
  _Later_savedState createState() => _Later_savedState();
}

class _Later_savedState extends State<Later_saved> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading = true;

  bool _isVisible = false;

  void show() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }
  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null){
      print('user is null');
    }
    return StreamProvider<List<Nara>>.value(
      value: DatabaseService().Unara,
      child: Scaffold(
        appBar:
        AppBar(
          centerTitle: true,
          //  backgroundColor:Theme.of(context).primaryColor,// Colors.redAccent,
          elevation: 0.0,
          leading: Builder( builder: (context){return IconButton(icon: Icon(Icons.menu,color: Theme.of(context).primaryColor), onPressed: (){Scaffold.of(context).openDrawer();},);},),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text('NARA'),
              Text(
                ' News',
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: Search(articles),
              ),
            ),
            Visibility( visible: _isVisible,
                child:Expanded(child: TextField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                ))
            )
          ],

        ),

        body: loading
            ? Loading()
            : SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: <Widget>[
                ArticleSavedList(
                  articles: articles,
                  NewsUrl: widget.newsUrl
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }




}


