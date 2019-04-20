import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../model/cart_info.dart';
import './cart_count.dart';
import '../../provide/cart_provide.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    print(item);
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _cartCheckBt(context, item),
          _cartImage(),
          _cartGoodsName(),
          _cartPrice(context)
        ],
      ),
    );
  }

  // 复选框
  Widget _cartCheckBt(context, item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          item.isCheck = val;
          Provide.value<CartProvide>(context).changeCheckState(item);
        },
      ),
    );
  }

  // 商品图片
  Widget _cartImage() {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(item.images),
    );
  }

  // 商品名称
  Widget _cartGoodsName() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[Text(item.goodsName), CartCount(item)],
      ),
    );
  }

  // 商品价格
  Widget _cartPrice(context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context).deleteGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
