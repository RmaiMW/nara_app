import 'package:flutter/material.dart';
import 'package:nara_app/helper/data.dart';
import 'package:nara_app/helper/news.dart';
import 'package:nara_app/models/article_model.dart';
import 'package:nara_app/models/category_model.dart';
import 'package:nara_app/views/article_list.dart';
import 'package:nara_app/views/category_list.dart';
import 'geustprofile.dart';
import 'loading.dart';
import 'recommendation.dart';

class geustHome extends StatefulWidget {
  @override
  _geustHomeState createState() => _geustHomeState();
}

class _geustHomeState extends State<geustHome> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading = true;


  @override
  void initState() {
    super.initState();
    categories = getCategories();
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
    return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.redAccent,
              elevation: 0.0,
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

                    /// Categories
                    CategoryList(
                      categories: categories,
                    ),

                    /// Blogs
                    ArticleList(
                      articles: articles,
                    ),
                  ],
                ),
              ),
            ),

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              selectedFontSize: 14,
              unselectedFontSize: 13,
              unselectedItemColor: Colors.blueGrey,
              selectedItemColor: Colors.redAccent,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),
                  //_selectedIndex==0?Icon(Icons.home,color: Colors.blueGrey):Icon(Icons.home,color: Colors.redAccent,),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Profile',),
              ],
              onTap: _onItemTapped,
            ),
          );
  }
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
      if (_selectedIndex == 0) Navigator.push(context, MaterialPageRoute(builder: (context) => geustHome()));
      else Navigator.push(context,MaterialPageRoute(builder: (context)=>geustProfile()));
    });
  }
}
