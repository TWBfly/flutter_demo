import 'package:flutter/material.dart';
import 'package:flutter_app_test/provider/multi_provider/second_multi_provider_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProvider 具有读写  Provider只有读
    return MultiProvider(
      providers: [
        Provider.value(value: 30.0),//注入字体大小
        ChangeNotifierProvider.value(value: CounterModel())//注入计数器实例
      ],
      child: MaterialApp(title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue,), home: MyHomePage(),),);
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //取出资源
    final _counter = Provider.of<CounterModel>(context);//获取计时器实例
    final textSize = Provider.of<double>(context);//获取字体大小

    return Scaffold(
        appBar: AppBar(title: Text("First Provider Screen"),),
        body:Center(child: Text('Counter: ${_counter.counter}',style: TextStyle(fontSize: textSize,),)),
        floatingActionButton: FloatingActionButton( onPressed: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondMultiProviderPage())),
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



