import 'package:flutter/material.dart';
import '../model/category_model.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类选中索引值
  String categoryId = '4';
  String subId = ''; //小类ID
  int page = 1; // 列表页数
  String noMoreText = ''; // 没有数据提示文字
  
  getChildCategory(List<BxMallSubDto> list, String id) {
    childIndex = 0;
    categoryId = id;
    page = 1;
    noMoreText = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(index, String id) {
    childIndex = index;
    subId = id;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  // 下拉增加页数
  addPage() {
    page++;
  }

  // 改变没有数据显示文字
  changeNoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }

}