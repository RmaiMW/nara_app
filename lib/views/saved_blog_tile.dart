import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/database.dart';
import 'package:nara_app/views/Saved.dart';
import 'package:nara_app/views/loading.dart';
import 'package:provider/provider.dart';
import 'article_view.dart';
class SavedBlogTile extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final String url;


  SavedBlogTile({
    @required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.url,
  });
  @override
  _SavedBlogTileState createState() => _SavedBlogTileState();
}

class _SavedBlogTileState extends State<SavedBlogTile> {
  var _formKey = GlobalKey<FormState>();
  List newsUrl = [];
  String imageUrl, title, desc, url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsUrl.clear();
  }
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: widget.url,
            ),
          ),
        );
      },
    child: StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {

            if (snapshot.hasData) {
                  UserData userData = snapshot.data;
                  newsUrl.addAll(userData.NewsUrl);
                  print(newsUrl);
                  imageUrl = widget.imageUrl;
                  title = widget.title;
                  desc = widget.desc;
                  url= widget.url;
            return Form(
              key: _formKey,
              child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Column(
                  children: <Widget>[
                    FlatButton.icon(
                      onPressed: () {
                        //setState(() {});
                      },
                        icon: IconButton(icon: Icon(Icons.close, color: Colors.red,),
                          onPressed: () async{
                            newsUrl.removeWhere((element) => '${element}' == url);
                              print(newsUrl);
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(userData.username, newsUrl,
                                  userData.iconImage,userData.Category);
                              //print(newsUrl);

                          setState(()  {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                      LaterSaved(newsUrl: newsUrl)));
                              Fluttertoast.showToast(
                                  msg: "Done",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.black,
                                  fontSize: 16.0
                              );
                          });



                          }),
                        label: Text('')),

                          ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(imageUrl),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                            ),
                          Text(
                              desc,
                              style: TextStyle(
                              color: Colors.black54,
                              ),
                            ),
                          ],
            ),),);
               }
            else{
              return Loading();
            }
    }
    ));
  }

}
