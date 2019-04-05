import 'package:flutter/material.dart';
import '../model/details_model.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsProvide with ChangeNotifier {
  DetailsModel details = null;

  bool isLeft = true;
  bool isRight = false;

  // tabbar的切换方法
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  // 从后台获取商品信息
  getGoodsDetail(String id) async {
    var formData = {'goodId': id};
    await request('getGoodDetailById', formData: formData).then((val) {
      var responseData = json.decode(val.toString());
      print(responseData);
      details = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }
}
