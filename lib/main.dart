import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category_provide.dart';
import './provide/category_goods_list_provide.dart';

//测试
void main() {
  var counter = Counter();
  var childCategoryProvide = ChildCategoryProvide();
  var categroyGoodsListProvide = CategoryGoodsListProvide();
  var providers = Providers();
  providers
  ..provide(Provider<Counter>.value(counter))
  ..provide(Provider<ChildCategoryProvide>.value(childCategoryProvide))
  ..provide(Provider<CategoryGoodsListProvide>.value(categroyGoodsListProvide));
  runApp(
    ProviderNode(
      child: MyApp(),
      providers: providers,
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}