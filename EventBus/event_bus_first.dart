import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import 'event_bus_second.dart';

void main() => runApp(MyApp());

EventBus eventBus = new EventBus();

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
  String msg = "通知：";
  StreamSubscription subscription;

  @override
  void initState() {
    //监听CustomEvent事件，刷新UI
    subscription = eventBus.on().listen((event) {
      if(event.runtimeType == CustomEvent){
        setState(() {
          msg += event.msg;
        }); //更新msg
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("EventBus FirstPage")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(msg),
            RaisedButton(
                child: Text("跳转EventBus SecondPage"),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventBusSecond()),
                    )),
          ],
        ));
  }

  @override
  void dispose() {
    subscription.cancel(); //销毁
    super.dispose();
  }
}

class CustomEvent {
  String msg;
  CustomEvent(this.msg);
}
class OneEvent {
  String msg;
  OneEvent(this.msg);
}