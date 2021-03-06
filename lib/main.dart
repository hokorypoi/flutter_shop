import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category_provide.dart';
import './provide/category_goods_list_provide.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/application.dart';
import './provide/details_provide.dart';
import './provide/cart_provide.dart';
import './provide/current_index.dart';

void main() {
  var counter = Counter();
  var childCategoryProvide = ChildCategoryProvide();
  var categroyGoodsListProvide = CategoryGoodsListProvide();
  var detailsProvide = DetailsProvide();
  var cartProvide = CartProvide();
  var providers = Providers();
  var currentIndexProvide = CurrentIndexProvide();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategoryProvide>.value(childCategoryProvide))
    ..provide(Provider<CategoryGoodsListProvide>.value(categroyGoodsListProvide))
    ..provide(Provider<DetailsProvide>.value(detailsProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
