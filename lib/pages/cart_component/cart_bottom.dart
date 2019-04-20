import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart_provide.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.white,
      child: Provide<CartProvide>(
        builder: (context, child, val) {
          return Row(
            children: <Widget>[
              _selectAllBtn(context),
              _allPrice(context),
              _goButton(context)
            ],
          );
        },
      ),
    );
  }

  // 全选按钮
  Widget _selectAllBtn(context) {
    bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              Provide.value<CartProvide>(context).changeAllCheckBtnState(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  Widget _allPrice(context) {
    double totalPrice = Provide.value<CartProvide>(context).totalPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setHeight(230),
                child: Text(
                  '合计',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(200),
                child: Text(
                  '￥ $totalPrice',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36), color: Colors.red),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
            ),
          )
        ],
      ),
    );
  }

  Widget _goButton(context) {
    int totalCount = Provide.value<CartProvide>(context).totalCount;
    return Container(
      width: ScreenUtil().setWidth(200),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3)),
          child: Text(
            '结算（$totalCount）',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
