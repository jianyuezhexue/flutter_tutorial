import 'package:flutter/material.dart';
import 'package:flutter_sample/config/application.dart';
import 'package:flutter_sample/config/routes.dart';
import './view/home_page.dart';
import 'package:fluro/fluro.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //main.dart容器类的构造函数里初始化路由
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(),
      onGenerateRoute: Application.router.generator,
    );
    return app;
  }
}
