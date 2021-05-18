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
import 'package:nara_app/views/hotnews.dart';
import 'package:nara_app/views/wrapper.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'loading.dart';
import 'recommendation.dart';
import 'search.dart';


class MainPage extends StatefulWidget {


  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading = true;
  var _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final StorageRepo _storageRepo=StorageRepo();
  bool isSwitched = false;
  List _News = [];
  int _selectedIndex = 0;
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
    await newsClass.getNews();
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
    final List<Widget> _children = [
      Home(),
      Recomm(cat:category),
      HotNews()
    ];
    User user = Provider.of<User>(context);
    return StreamProvider<List<Nara>>.value(
      value: DatabaseService().Unara,
      child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              _News.addAll(userData.NewsUrl);
              category= userData.Category;

              return Form(
                key: _formKey,
                child: Scaffold(
                  appBar:
                  AppBar(
                    centerTitle: true,
                    //  backgroundColor:Theme.of(context).primaryColor,// Colors.redAccent,
                    elevation: 0.0,
                    leading: Builder(builder: (context) {
                      return IconButton(
                        icon: Icon(Icons.menu, color: Colors.white), onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },);
                    },),
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
                        onPressed: () =>
                            showSearch(
                              context: context,
                              delegate: Search(articles),
                            ),
                      ),
                      Visibility(visible: _isVisible,
                          child: Expanded(child: TextField(
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)))),
                          ))
                      )
                    ],
                  ),
                  drawer: Drawer(
                    child: ListView(
                      children: <Widget>[
                        DrawerHeader(

                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                Theme.of(context).primaryColor,
                                Theme.of(context).secondaryHeaderColor
                              ])
                          ),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(8.0),
                                  child:Avatar(
                                    avatarUrl: userData?.iconImage,
                                    onTap: () async {
                                      File image = await ImagePicker.pickImage(
                                          source: ImageSource.gallery);

                                      await _storageRepo.uploadFile(image);
                                      await DatabaseService(uid: user.uid).updateUserData(userData.username,userData.NewsUrl ,await _storageRepo.getUserProfileImage(user.uid),userData.Category);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                Text(userData.username,style: TextStyle(color: Colors.white,fontSize: 18.0),)
                              ],
                            ),
                          ),
                        ),
                        CustomizeListTile(Icons.person,'Profile', _showname),
                        CustomizeListTile(Icons.notifications,'Notifications', ()=>{}),
                        CustomizeListTile(Icons.favorite,'Favorite', () {Navigator.push(context, MaterialPageRoute(builder: (context)=>LaterSaved(newsUrl: _News)));}),
                        CustomizeListTile(Icons.change_history,'Change Theme', _changetheme),
                        CustomizeListTile(Icons.password,'Change Password', () {Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePass()));}),
                        CustomizeListTile(Icons.logout,'Log out', () async {await _auth.signout();
                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper()));
                          }),
                      ],
                    ),
                  ),

                  body: loading
                      ? Loading()
                      : _children[_selectedIndex],

                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: _selectedIndex,
                    selectedFontSize: 14,
                    unselectedFontSize: 13,
                    unselectedItemColor: Colors.grey[500],
                    selectedItemColor: Theme.of(context).primaryColor,
                    items: [
                      BottomNavigationBarItem(icon: Icon(Icons.home),
                        //_selectedIndex==0?Icon(Icons.home,color: Colors.blueGrey):Icon(Icons.home,color: Colors.redAccent,),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.recommend), label: 'Recommend',),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.local_fire_department), label: 'Hot',)
                    ],
                    onTap: _onItemTapped,
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


