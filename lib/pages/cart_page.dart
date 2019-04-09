import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> testList = [];

  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(testList[index]),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              _add();
            },
            child: Text('增加'),
          ),
          RaisedButton(
            onPressed: () {
              _clear();
            },
            child: Text('清空'),
          )
        ],
      ),
    );
  }

  // 增加方法
  void _add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = '233';
    testList.add(temp);
    prefs.setStringList('list', testList);
    _show();
  }

  // 查询
  void _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('list') != null) {
      setState(() {
        testList = prefs.getStringList('list');
      });
    } 
  }

  // 删除
  void _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    prefs.remove('list');
    setState(() {
      testList = [];
    });
  }

}