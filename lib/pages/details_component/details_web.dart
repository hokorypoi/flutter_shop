import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../provide/details_provide.dart';
<<<<<<< HEAD
import 'package:flutter_screenutil/flutter_screenutil.dart';
=======
>>>>>>> a6a53d193111f0e82d57d2f31f6d665e46937489

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<DetailsProvide>(context).details.data.goodInfo.goodsDetail;
<<<<<<< HEAD
    return Provide<DetailsProvide>(
      builder: (context, child, val) {
        var isLeft = Provide.value<DetailsProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(
              data: goodsDetails,
            ),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10),
            child: Text('暂时没有数据'),
            alignment: Alignment.center,
          );
        }
      },
=======
    return Container(
      child: Html(
        data: goodsDetails
      ),
>>>>>>> a6a53d193111f0e82d57d2f31f6d665e46937489
    );
  }
}