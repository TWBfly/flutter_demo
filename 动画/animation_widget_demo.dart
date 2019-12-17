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
    animation = Tween(begin: 50.0, end: 200.0).animate(curve);
    //      ..addListener(() {
    //        setState(() {}); //刷新界面
    //      });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行完成
        print("completed");
        controller.reverse();//动画结束时反向执行
      }else if(status == AnimationStatus.forward) {
        //动画开始执行
        print("forward");
      }else if(status == AnimationStatus.reverse){
        //动画重复执行
        print("reverse");
      }
      else if (status == AnimationStatus.dismissed) {
        //动画执行一个循环
        print("dismissed");
//        controller.forward();//动画反向执行完毕时，重新执行
      }
    });
    controller.forward(); //启动动画
    print("isdismiss:${controller.isDismissed}");
//    controller.repeat(reverse: true); //让动画重复执行
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animaiton demo")), //      body: AnimatedLogo(animation: animation),
      body: Center(
          child: AnimatedBuilder(
              animation: animation, //传入动画对象
              child: FlutterLogo(),
              builder: (context, child) => Container(
                    width: animation.value, //使用动画的当前状态更新UI
                    height: animation.value, child: child, //child参数即FlutterLogo()
                  ))),
    );
  }

  @override
  void dispose() {
    controller.dispose(); // 释放资源
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  //AnimatedWidget需要在初始化时传入animation对象
  AnimatedLogo({Key key, Animation<double> animation}) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    //取出动画对象
    final Animation<double> animation = listenable;
    return Center(
        child: Container(
      height: animation.value, //根据动画对象的当前状态更新宽高
      width: animation.value, child: FlutterLogo(),
    ));
  }
}
