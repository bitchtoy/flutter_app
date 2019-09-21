import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "Welcome To Flutter",
      home: new RandomWords(),
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text("Welcome To Flutter"),
//        ),
//        body: new Center(
//          child: new RandomWords(),
//        ),
//      ),
    );
  }
}
class RandomWords extends StatefulWidget{
  @override
  createState()=> new RandomWordsPair();
}
class RandomWordsPair extends State{
  final int two = 2;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("FlutterListView"),
      ),
      body: _buildSuggestion(),
    );
  }
  final _suggestion = <WordPair>[];
  final _fontStyle = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();
  Widget _buildSuggestion(){
   return new ListView.builder(padding: const EdgeInsets.all(16.0),
       itemBuilder: (context,i){
       //item  底部线条
       if(i.isOdd) return new Divider();
       /**此处 底部线条 也占i 的一个位置，这块可以理解整除吧？不过官方介绍是向后取整*/
       final index = i ~/ two;
       /***/
       if(index >= _suggestion.length){
         _suggestion.addAll(generateWordPairs().take(10));
       }
       return _buildRow(_suggestion[index]);

   });
 }
 Widget _buildRow(WordPair pair){
    final _alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(pair.asPascalCase,style: _fontStyle),
      trailing: new Icon(_alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null),
      onTap: (){
        setState(() {
          _alreadySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },

    );

 }
}

//class RandomWords extends StatefulWidget {
//  @override
//  createState() => new RandomWordsPair();
//}

//class RandomWordsPair extends State<RandomWords> {
//  final _suggestions = <WordPair>[];
//  final _biggerFont = const TextStyle(fontSize: 18.0);
//  final _saved = new Set<WordPair>();
//  Widget _buildSuggestions() {
//    return new ListView.builder(
//        padding: const EdgeInsets.all(16.0),
//        itemBuilder: (context, i) {
//          if (i.isOdd) return new Divider();
//          final index = i ~/ 2;
//          if (index >= _suggestions.length) {
//            _suggestions.addAll(generateWordPairs().take(10));
//          }
//          return _buildRow(_suggestions[index]);
//        });
//  }
//  Widget _buildRow(WordPair pair){
//    final _alreadySaved = _saved.contains(pair);
//    return new ListTile(
//      title: new Text(
//        pair.asPascalCase,style: _biggerFont,
//      ),
//      trailing: new Icon(
//          _alreadySaved ? Icons.favorite : Icons.favorite_border,
//        color: _alreadySaved ? Colors.red : null,
//      ),
//      onTap: (){
//        setState(() {
//          if(_alreadySaved){
//            _saved.remove(pair);
//          }else{
//            _saved.add(pair);
//          }
//        });
//      },
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("Startup Game Generation"),
//        actions: <Widget>[new IconButton(icon: new Icon(Icons.list),onPressed: _pushSaved,)],
//      ),
//      body: _buildSuggestions(),
//    );
//  }
//  void _pushSaved(){
//    Navigator.of(context).push(
//      new MaterialPageRoute(builder: (context){
//        final tiles = _saved.map(
//            (pair){
//              return new ListTile(
//                title: new Text(
//                  pair.asPascalCase,
//                  style: _biggerFont,
//                ),
//              );
//            }
//        );
//        final divided = ListTile.divideTiles(tiles: tiles,context: context).toList();
//        return new Scaffold(
//          appBar: new AppBar(title: new Text("Saved Suggesstion")),
//          body: new ListView(children: divided),
//        );
//      })
//    );
//  }
//}
