import 'package:flutter/material.dart';
import 'package:nara_app/helper/data.dart';
import 'package:nara_app/helper/news.dart';
import 'package:nara_app/models/Nara.dart';
import 'package:nara_app/models/article_model.dart';
import 'package:nara_app/models/category_model.dart';
import 'package:nara_app/services/auth.dart';
import 'package:nara_app/services/database.dart';
import 'package:nara_app/views/article_list.dart';
import 'package:nara_app/views/category_list.dart';
import 'package:provider/provider.dart';
import 'geustprofile.dart';
import 'loading.dart';
import 'profile.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  final AuthService _auth = AuthService();
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
    return StreamProvider<List<Nara>>.value(
      value: DatabaseService().Unara,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          elevation: 0.0,
          leading: Builder( builder: (context){return IconButton(icon: Icon(Icons.menu,color: Colors.redAccent,), onPressed: (){Scaffold.of(context).openDrawer();},);},),
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

              Align(
                  alignment: Alignment.centerLeft,
                  child: FlatButton.icon(onPressed:show,
                    icon: Icon(Icons.search,color: Colors.white,),

                    label:Text(''),),
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
      ),
    );
  }



  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
      if (_selectedIndex == 0) Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      else{
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Profile()));
      }
    });
  }

}
