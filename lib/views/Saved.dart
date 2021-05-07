import 'package:flutter/material.dart';
import 'package:nara_app/helper/news.dart';
import 'package:nara_app/models/Nara.dart';
import 'package:nara_app/models/saved_model.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/database.dart';
import 'package:nara_app/views/saved_list.dart';
import 'package:provider/provider.dart';
import 'loading.dart';

class LaterSaved extends StatefulWidget {
  final List newsUrl;
  LaterSaved({@required this.newsUrl});

  @override
  _LaterSavedState createState() => _LaterSavedState();
}

class _LaterSavedState extends State<LaterSaved> {
  List<SavedArticleModel> articles = new List<SavedArticleModel>();

  bool loading = true;

  bool _isVisible = false;
  List Urls_news = [];
  void show() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    getSavedNews();
  }
  getSavedNews() async {
    Urls_news.addAll(widget.newsUrl);
    News newsClass = News();
    await newsClass.getSavedNews(Urls_news);
    articles = newsClass.SavedNews;
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
                SavedArticleList(
                  articles: articles,
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }




}


