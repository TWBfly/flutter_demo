import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import 'event_bus_first.dart';

class EventBusSecond extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EventBusSecond> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("EventBus SecondPage")),
        body:RaisedButton(onPressed: () {
          eventBus.fire(CustomEvent("来自第二个页面的数据  "));
          eventBus.fire(OneEvent("来自OneEvent的数据  "));

        },child: Text("点击发送Event给FirstPage"),));
  }
}

