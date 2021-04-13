import 'package:flutter/material.dart';

class Search extends SearchDelegate{

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(icon: Icon(Icons.clear),
          onPressed: ()=>query="",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if(query == '') return Center(child: Text('Enter Keyword'),);
    return Center(child: Text(' Keyword'),);

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query == '') return Center(child: Text('Enter keyword'));
    return Center(child: Text('Keyword'),);
  }

}