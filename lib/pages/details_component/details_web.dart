import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../provide/details_provide.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<DetailsProvide>(context).details.data.goodInfo.goodsDetail;
    return Container(
      child: Html(
        data: goodsDetails
      ),
    );
  }
}