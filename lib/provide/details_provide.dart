import 'package:flutter/material.dart';
import '../model/details_model.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsProvide with ChangeNotifier {
  DetailsModel details = null;

  // 从后台获取商品信息
  getGoodsDetail(String id) {
    var formData = {'goodId': id};
    request('getGoodDetailById', formData: formData).then((val){
      var responseData = json.decode(val.toString());
      print(responseData);
      details = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }
}