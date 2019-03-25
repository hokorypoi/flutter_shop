import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category_model.dart';
import '../model/category_goods_list_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category_provide.dart';
import '../provide/category_goods_list_provide.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// 左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    super.initState();
    _getGategory();
    _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _leftInkWell(index);
          },
        ));
  }

  Widget _leftInkWell(int index) {
    var isClick = index == listIndex;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategoryProvide>(context)
            .getChildCategory(childList);
            _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1) : Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(26)),
        ),
      ),
    );
  }

  void _getGategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategoryProvide>(context)
          .getChildCategory(list[0].bxMallSubDto);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {'categoryId': categoryId == null ? '4' :categoryId, 'categorySubId': '', 'page': 1};
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategoryProvide>(
      builder: (context, child, childCategory) {
        return Container(
          width: ScreenUtil().setWidth(570),
          height: ScreenUtil().setHeight(80),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(childCategory.childCategoryList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(BxMallSubDto item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}

// 商品列表，可上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
          builder: (context, child, data) {
            return Container(
              width: ScreenUtil().setWidth(570),
              height: ScreenUtil().setHeight(960),
              child: ListView.builder(
                itemCount: data.goodsList.length,
                itemBuilder: (context, index) {
                  return _listItemWidget(data.goodsList[index]);
                },
              ),
      );
          },
    );
  }

  Widget _goodsImage(CategoryListData data) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(data.image),
    );
  }

  Widget _goodsName(CategoryListData data) {
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.all(5),
      child: Text(
        data.goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(CategoryListData data) {
    return Container(
        width: ScreenUtil().setWidth(370),
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: <Widget>[
            Text(
              '价格：￥${data.presentPrice}',
              style: TextStyle(
                  color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
            ),
            Text(
              '价格：￥${data.oriPrice}',
              style: TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough),
            )
          ],
        ));
  }

  Widget _listItemWidget(CategoryListData data) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(data),
            Column(
              children: <Widget>[_goodsName(data), _goodsPrice(data)],
            )
          ],
        ),
      ),
    );
  }
}
