import 'package:flutter/material.dart';
import '../model/category_goods_list_model.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];
  
  // 点击大类时，更换商品列表
  getGoodsList(List<CategoryListData> list) {
    goodsList = list;
    notifyListeners();
  }

    getMoreGoodsList(List<CategoryListData> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}