import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cart_info.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];
  double totalPrice = 0;
  int totalCount = 0;

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool exists = false;
    int i = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[i]['count'] = item['count'] + 1;
        cartList[i].count++;
        exists = true;
      }
      i++;
    });

    Map<String, dynamic> newGoods = {
      'goodsId': goodsId,
      'goodsName': goodsName,
      'count': count,
      'price': price,
      'images': images,
      'isCheck': true
    };

    if (!exists) {
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    print('字符串：${cartString}');
    print('数据模型：${cartList}');
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = [];
    print('清空完成------------------');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if (cartString == null) {
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      totalCount = 0;
      totalPrice = 0;
      tempList.forEach((item) {
        cartList.add(CartInfoModel.fromJson(item));
        if (item['isCheck']) {
          totalCount += item['count'];
          totalPrice += (item['count'] * item['price']);
        }
      });
    }
    notifyListeners();
  }

  deleteGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int i = 0;
    int index = -1;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        index = i;
      }
      i++;
    });
    tempList.removeAt(index);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    getCartInfo();
  }
}
