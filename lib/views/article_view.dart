import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  ArticleView({this.blogUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  double _currentSliderValue = 20;
  bool _fav =false;
  void favorite() {
    setState(() {
      _fav = !_fav;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        actions: <Widget>[Builder( builder: (context){return IconButton(icon: Icon(Icons.format_size_sharp,color: Colors.white,), onPressed: (){Scaffold.of(context).openEndDrawer();},);},)],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton.icon(onPressed:(){ }, icon:IconButton(icon:Icon(_fav?Icons.favorite:Icons.favorite_border,color: Colors.white), onPressed: () { favorite(); },), label: Text('')),
            FlatButton.icon(onPressed: (){}, icon: IconButton(icon:Icon(Icons.public,color: Colors.white,),onPressed: (){},), label: Text('')),
           /* Text('NARA'),
            Text(
              ' News',
              style: TextStyle(
                color: Colors.blueGrey,
              ),
            ),*/
          ],
        ),
      ),
      endDrawer: Padding(
        padding: const EdgeInsets.fromLTRB(60, 60, 20, 570),
        child: Container(//margin: EdgeInsets.only(top: 20,left: 1,right: 40,bottom: 20),
            color: Colors.white,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Choose size of line\t',style: TextStyle(color: Colors.redAccent,fontWeight:FontWeight.bold),),Slider(activeColor:Colors.redAccent,value: _currentSliderValue,min: 20,max: 40,divisions: 5,label: _currentSliderValue.round().toString(), onChanged: (double s){ setState(() {
              _currentSliderValue=s;
            });})],)
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController) {
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
