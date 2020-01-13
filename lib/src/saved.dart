import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class SavedList extends StatefulWidget {

  //! 생성자 {@required 변수} 구조를 사용함
  SavedList({@required this.saved});

  final Set<WordPair> saved;

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
      ),
      //body : Text(saved.toString(), textScaleFactor: 2, ),
      body : _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(itemCount: widget.saved.length*2, itemBuilder: (context, index) {
      if( index.isOdd ) {
        return Divider();
      }

      //! 나머지
      var realIndex = index ~/ 2;

      //! 리스트 타일 획득
      return _buildRow(widget.saved.toList()[realIndex]);

    });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(pair.asPascalCase, textScaleFactor: 1.5,),
      onTap: (){
        setState(() {
          widget.saved.remove(pair);
        });
      }
    );
  }
}
