import 'dart:async';

import 'package:flutter/material.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    //创建动画周期为1秒的AnimationController对象
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    //创建一条震荡曲线
    final CurvedAnimation curve = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    // 创建从50到200跟随振荡曲线变化的Animation对象
    animation = Tween(begin: 50.0, end: 200.0).animate(curve)
      ..addListener(() {
        setState(() {}); //刷新界面
      });

    // 创建从50到200线性变化的Animation对象
    //    animation = Tween(begin: 50.0, end: 200.0).animate(controller)
    //      ..addListener(() {
    //        setState(() {}); //刷新界面
    //      });

    controller.forward(); //启动动画
    controller.repeat(reverse: true); //让动画重复执行
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Animaiton demo")),
        body: Center(
          child: Container(
              width: animation.value, // 将动画的值赋给widget的宽高
              height: animation.value,
              child: FlutterLogo()),
        ));
  }

  @override
  void dispose() {
    controller.dispose(); // 释放资源
    super.dispose();
  }
}
