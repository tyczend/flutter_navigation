import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_navigation/src/saved.dart';

class controlRandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RamdomWordState();
  }
}

// 상태가 변경될 때마다 호출
class _RamdomWordState extends State<controlRandomList> {
  //! 중복 가능
  final List<WordPair> _suggestions = <WordPair>[];

  //! 중복 불가
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("avigation Test"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>SavedList(saved: _saved,))
              );
            },
          )
        ],
      ),
      //body: Center(child: Text(randomWord.asPascalCase, textScaleFactor: 1.5,),),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      // 리스트 컨트롤러의 배열은 라인이 index를 가짐
      if (index.isOdd) {
        // 라인을 그림
        return Divider();
      }

      //! List control index를 일반 배열 index변환
      var realIndex = index ~/ 2;

      //! 단어 입력
      if (realIndex >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }

      return _buildRow(_suggestions[realIndex]);
    });
  }

   Widget _buildRow(WordPair pair) {

      //! pair 단어 확인
      final bool alreadySaved = _saved.contains(pair);

      return ListTile(
        title: Text(pair.asPascalCase,
              textScaleFactor: 1.5),
        trailing: Icon(
          alreadySaved ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.pink,
        ),
        onTap: () {
          //! 상태값이 변경될 때 적용
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            }
            else {
              _saved.add(pair);
            }
            print(_saved.toString());
          });
        },
      );
   }
}
