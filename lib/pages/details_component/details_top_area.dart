import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsProvide>(
      builder: (context, child, val) {
        var goodsInfo =
            Provide.value<DetailsProvide>(context).details.data.goodInfo;
        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
              ],
            ),
          );
        } else {
          return Text('正在加载中......');
        }
      },
    );
  }

  Widget _goodsImage(url) {
    return Image.network(url, width: ScreenUtil().setWidth(740));
  }

  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      margin: EdgeInsets.only(top: 15),
      child: Text('$name', style: TextStyle(fontSize: ScreenUtil().setSp(30))),
    );
  }

  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号：${num}',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  Widget _goodsPrice(presentPrice, oriPrice) {
    return Container(
        width: ScreenUtil().setWidth(740),
        padding: EdgeInsets.only(left: 15),
        margin: EdgeInsets.only(top: 8),
        child: Row(
          children: <Widget>[
            Text(
              '￥${presentPrice}',
              style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: ScreenUtil().setSp(40)
              ),
            ),
            Text(
              '￥商场价${oriPrice}',
              style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough 
              ),
            )
          ],
        ));
  }
}