import 'package:flutter/material.dart';
import 'package:nara_app/helper/data.dart';
import 'package:nara_app/helper/news.dart';
import 'package:nara_app/models/Nara.dart';
import 'package:nara_app/models/article_model.dart';
import 'package:nara_app/models/category_model.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/auth.dart';
import 'package:nara_app/services/database.dart';
import 'package:nara_app/views/article_list.dart';
import 'package:nara_app/views/category_list.dart';
import 'package:provider/provider.dart';
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
              FlatButton.icon(
               icon: Icon(Icons.person),
               label: Text('logout'),
              onPressed: () async {
                  await _auth.signOut();
                },
             ),]
        ),

        body: loading
            ? Loading()
        //Center(
        //      child: Container(
        //      child: CircularProgressIndicator(),
        //  ),
        //)
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
        /*  bottomNavigationBar: BottomNavigationBar(
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


            ),*/
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
      else Navigator.push(context,MaterialPageRoute(builder: (context)=>Profile()));
    });
  }
}
