import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:async';

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

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("MethodChannel Demo"),), body: Column(children: <Widget>[RaisedButton(onPressed: () {
      handleButtonClick();
    }, child: Text("MethodChannel"),),
    ],));
  }


  //处理按钮点击
  handleButtonClick() async {
    //声明MethodChannel
    const platform = MethodChannel('tami');
    var result;
    //异常捕获
    try {
      //异步等待方法通道的调用结果
      result = await platform.invokeMethod('123456');
    } catch (e) {
      result = -1;
    }
    print("Result：$result");
  }

}
