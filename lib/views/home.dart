import 'package:flutter/material.dart';
import 'package:nara_app/Reg_and_logo/CommonLogo.dart';
import 'package:nara_app/helper/data.dart';
import 'package:nara_app/helper/news.dart';
import 'package:nara_app/models/article_model.dart';
import 'package:nara_app/models/category_model.dart';
import 'package:nara_app/views/article_list.dart';
import 'package:nara_app/views/category_list.dart';

import '../profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = true;

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
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
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

      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
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
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon:IconButton(icon:Icon(Icons.home_rounded,color: Colors.blueGrey,), onPressed: () { Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home())); },) ,
              label: 'Home',
              //title: Text('Home',style: TextStyle(color: Colors.blueGrey),)
            ),
            BottomNavigationBarItem(icon:IconButton(icon:Icon(Icons.account_circle,color: Colors.blueGrey,), onPressed: () { Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Profile())); },) ,
              label: 'Profile',
            ),
          ],
          fixedColor: Colors.blueGrey,
          //  currentIndex: _selectedIndex,
          // selectedItemColor: Colors.redAccent[100],
          //   onTap: _onItemTapped,


        ),

    );

  }
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
      if (_selectedIndex == 0) Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }
}
