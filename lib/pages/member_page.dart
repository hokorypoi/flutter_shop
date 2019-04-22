import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _header(),
          _orderTitle(),
          _orderType(),
          _actionList(),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network(
                  'http://blogimages.jspang.com/blogtouxiang1.jpg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'HOKORI',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36), color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }

  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: Colors.white12,
          ))),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(
        top: 20,
      ),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.money_off,
                  size: 30,
                ),
                Text('待付款')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text('待收获')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.comment,
                  size: 30,
                ),
                Text('待评价')
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listTileItem(item) {
    Icon iconL = item['iconL'];
    String title = item['title'];
    Icon iconT = item['iconT'];
    print(item);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: iconL,
        title: Text(title),
        trailing: iconT,
      ),
    );
  }

  Widget _actionList() {
    var actions = [
      {
        'iconL': Icon(Icons.traffic),
        'title': '领取优惠券',
        'iconT': Icon(Icons.arrow_forward_ios),
      },
      {
        'iconL': Icon(Icons.casino),
        'title': '已领取优惠券',
        'iconT': Icon(Icons.arrow_forward_ios),
      },
      {
        'iconL': Icon(Icons.explicit),
        'title': '地址管理',
        'iconT': Icon(Icons.arrow_forward_ios),
      },
      {
        'iconL': Icon(Icons.phone),
        'title': '客服电话',
        'iconT': Icon(Icons.arrow_forward_ios),
      },
    ];
    List<Widget> list = [];
    actions.forEach((val) {
      list.add(_listTileItem(val));
    });
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: list,
      ),
    );
  }
}
