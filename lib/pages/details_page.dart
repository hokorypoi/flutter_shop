import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_provide.dart';
import './details_component/details_top_area.dart';
import './details_component/details_description.dart';
import './details_component/details_tabbar.dart';
import './details_component/details_web.dart';
import './details_component/details_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        future: _getDetailInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsDescription(),
                      DetailsTabbar(),
                      DetailsWeb()
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: DetailsBottom(),
                )
              ],
            );
          } else {
            return Text('加载中。。。');
          }
        },
      ),
    );
  }

  Future _getDetailInfo(BuildContext context) async {
    await Provide.value<DetailsProvide>(context).getGoodsDetail(goodsId);
    return '完成加载';
  }
}
