import 'package:flutter/material.dart';
import 'package:flutter_app_test/second_page.dart';
import 'package:flutter_app_test/third_page.dart';
import 'package:flutter_app_test/un_known_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "second_page": (context) => SecondPage(),
        "third_page": (context) => ThirdPage(),
      },
      //错误路由处理，统一返回UnknownPage
      onUnknownRoute: (RouteSettings setting) => MaterialPageRoute(builder: (context) => UnknownPage()),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  List list = [1, "String", true];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Screen"),
      ),
      body: RaisedButton(
        onPressed: () {
          //          Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(firstTitle: "this is first page",firstList: list,)));
          //使用名字打开页面
          //          Navigator.pushNamed(context, "second_page",arguments:"这是FirstPage传递的参数");
          //返回传参
          //          Navigator.pushNamed(context, "second_page",arguments:"这是FirstPage传递的参数").then((msg)=>print("msg:$msg"));
          //传list
          //          Navigator.pushNamed(context, "second_page", arguments: list).then((msg) => print("msg:$msg"));
          //演示错误页面
          Navigator.pushNamed(context, "second_pages", arguments: list).then((msg) => print("msg:$msg"));
        },
        child: Text("Push Second Page"),
      ),
    );
  }
}
