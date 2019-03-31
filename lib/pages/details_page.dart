import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_provide.dart';

class DetailsPage extends StatelessWidget {

  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    _getDetailInfo(context);
    return Container(
      child: Center(
        child: Text('商品ID:$goodsId'),
      ),
    );
  }

  void _getDetailInfo(BuildContext context) async {
    await Provide.value<DetailsProvide>(context).getGoodsDetail(goodsId);
    print('加载完成。。。。。。。');
  }

}