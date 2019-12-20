import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'first_multi_provider_page.dart';

class SecondMultiProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
        appBar: AppBar(
          title: Text('Second Provider Screen'),
        ),
        body: Consumer2<double,CounterModel>(
          builder: (BuildContext context, double textSize,CounterModel value, Widget child) {
            return Center(child: Text('Value: ${value.counter}',style: TextStyle(fontSize: textSize,),));
          },
        ),
        floatingActionButton:Consumer2<double,CounterModel>(
          builder: (BuildContext context, double textSize, CounterModel value,Widget child) {
            return FloatingActionButton(
              //用资源更新方法来设置按钮点击回调
              onPressed:  value.increment,
              child: Icon(Icons.add),
            );
          },
        )
    );
  }
}
