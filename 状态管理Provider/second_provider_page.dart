import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'first_provider_page.dart';

//class SecondProviderPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    //取出资源
//    final _counter = Provider.of<CounterModel>(context);
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Second Provider Screen'),
//      ),
//      body: Center(child: Text('Counter: ${_counter.counter}')),
//      //用资源更新方法来设置按钮点击回调
//      floatingActionButton: FloatingActionButton(
//        onPressed: _counter.increment,
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}

class SecondProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Provider Screen'),
      ),
      body: Consumer<CounterModel>(
        builder: (BuildContext context, CounterModel value, Widget child) {
          return Text('Value: ${value.counter}');
        },
      ),
      floatingActionButton:Consumer<CounterModel>(
        builder: (BuildContext context, CounterModel value, Widget child) {
          return FloatingActionButton(
            //用资源更新方法来设置按钮点击回调
            onPressed: value.increment,
            child: Icon(Icons.add),
          );
        },
      )
    );
  }
}
