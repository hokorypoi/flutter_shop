import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cart_info.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];
  double totalPrice = 0;
  int totalCount = 0;
  bool isAllCheck = true;

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool exists = false;
    int i = 0;
    totalCount = 0;
    totalPrice = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[i]['count'] = item['count'] + 1;
        cartList[i].count++;
        exists = true;
      }
      if (item['isCheck']) {
        totalCount += (cartList[i].count);
        totalPrice += (cartList[i].count * cartList[i].price);
      }
      i++;
    });

    if (!exists) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true
      };

      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));

      totalCount += count;
      totalPrice += count * price;
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
      isAllCheck = true;
      tempList.forEach((item) {
        cartList.add(CartInfoModel.fromJson(item));
        if (item['isCheck']) {
          totalCount += item['count'];
          totalPrice += (item['count'] * item['price']);
        } else {
          isAllCheck = false;
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
    await getCartInfo();
  }

  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int i = 0;
    int index = -1;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        index = i;
      }
      i++;
    });
    tempList[index] = cartItem.toJson();
    cartString = json.encode(cartList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  addOrReduceAction(CartInfoModel cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int i = 0;
    int index = -1;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        index = i;
      }
      i++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[index] = cartItem.toJson();
    cartString = json.encode(cartList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
}
