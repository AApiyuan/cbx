import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/enum/select_type.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/goods_page_param.dart';
import 'package:haidai_flutter_module/page/home/home_controller.dart';
import 'package:haidai_flutter_module/page/nav/nav_page.dart';
import 'package:haidai_flutter_module/repository/check_api.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('data'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomeController controller = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
              color: Colors.amber,
              onPressed: () {
                // goodsPage();

                CheckApi.checkCenter(2301).then((value) {

                  if(value == null){
                    Get.toNamed(ArgUtils.map2String(path: Routes.CHECKEMPTY, arguments: {"depId": 2301}));
                  }else{
                    Get.toNamed(ArgUtils.map2String(path: Routes.CHECKING, arguments: {"depId": 2301}));
                  }

                }, onError: (e) {
                  print("flutter:   error1:$e");
                  Get.toNamed(ArgUtils.map2String(path: Routes.CHECKEMPTY, arguments: {"depId": 2301}));
                });

              },
              child: Text("获取商品")),
          FlatButton(
              color: Colors.amber,
              onPressed: () {
                Get.to(NavPage());
              },
              child: Text("nav")),
          FlatButton(
              color: Colors.amber,
              onPressed: () {
                controller.increment();
              },
              child: Text("plus")),
          FlatButton(
            color: Colors.amber,
            onPressed: () {
              Get.toNamed(ArgUtils.map2String(path: Routes.DIFFERENCE, arguments: {"id": 103}));
            },
            child: Text("查看差异"),
          ),
          FlatButton(
            color: Colors.amber,
            onPressed: () => Get.toNamed(ArgUtils.map2String(path: Routes.ENTER, arguments: {
              "orderId": 103,
              "deptId": 2,
              "isSubstandard": false
            })),
            child: Text("录入盘点"),
          ),
          FlatButton(
            color: Colors.amber,
            onPressed: () => Get.toNamed(ArgUtils.map2String(path: Routes.ENTER, arguments: {
              "orderId": 103,
              "recordId": 402,
              "deptId": 2,
            })),
            child: Text("修改录入盘点"),
          ),
          GetBuilder<HomeController>(builder: (controller) {
            return Text(controller.counter.toString());
          })
        ],
      ),
    );
  }
}

void goodsPage() async {
  BasePage page = new BasePage();
  page.pageNo = 1;
  page.pageSize = 10;
  GoodsPageParam param = new GoodsPageParam();
  param.deptId = 2;
  param.selectType = SelectType.BASIC;
  page.param = param;
  // List<Goods> entity = await GoodsApi.page({
  //   "param": {"deptId": 2, "selectType": "BASIC"}
  // });
  List<Goods> entity = await GoodsApi.page(page);
  print(entity);
}
