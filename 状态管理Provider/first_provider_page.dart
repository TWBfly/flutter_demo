import 'package:flutter/material.dart';
import 'package:flutter_app_test/provider/second_provider_page.dart';
import 'package:flutter_app_test/second_page.dart';
import 'package:flutter_app_test/third_page.dart';
import 'package:flutter_app_test/un_known_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProvider 具有读写  Provider只有读
    return ChangeNotifierProvider.value(
      value: CounterModel(),//需要共享的数据资源
      child: MaterialApp(title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue,), home: MyHomePage(),),);
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //取出资源
    final _counter = Provider.of<CounterModel>(context);
    return Scaffold(
        appBar: AppBar(title: Text("First Provider Screen"),),
        body:Center(child: Text('Counter: ${_counter.counter}')),
        floatingActionButton: FloatingActionButton( onPressed: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondProviderPage())),
        child: Icon(Icons.arrow_forward_ios),)
    );
  }
}


//定义需要共享的数据模型，通过混入ChangeNotifier管理
class CounterModel with ChangeNotifier {
  int _count = 0;

  //读方法
  int get counter => _count;

  //写方法
  void increment() {
    _count++;
    notifyListeners(); //通知刷新
  }
}



