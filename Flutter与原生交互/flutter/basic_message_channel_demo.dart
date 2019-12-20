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
  static const String _channel = 'BasicMessageChannel';
  static const String _pong = 'pong';
  static const String _emptyMessage = '';
  ///详细参考 https://www.jianshu.com/p/39575a90e820 或者源码
  //StandardMessageCodec() //BasicMessageChannel的默认编解码器，其支持基础数据类型、二进制数据、列表、字典
  //BinaryCodec() //二进制格式 Android中为ByteBuffer，iOS中为NSData
  //JSONMessageCodec() //adnroid  org.json ios NSJSONSerialization
  static const BasicMessageChannel<String> basicMessageChannel = BasicMessageChannel<String>(_channel, StringCodec());

  int _counter = 0;
  @override
  void initState() {
    super.initState();
    basicMessageChannel.setMessageHandler(_handlePlatformIncrement);
  }

  Future<String> _handlePlatformIncrement(String message) async {
    print("message:$message");
    setState(() {
      _counter++;
    });
    return _emptyMessage;
  }

  void _sendFlutterIncrement() {
    basicMessageChannel.send(_pong);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                  'Platform button tapped $_counter time${ _counter == 1 ? '' : 's' }.',
                  style: const TextStyle(fontSize: 17.0)),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 15.0, left: 5.0),
            child: Row(
              children: <Widget>[
                FlutterLogo(),
                const Text('Flutter', style: TextStyle(fontSize: 30.0)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendFlutterIncrement,
        child: const Icon(Icons.add),
      ),
    );
  }
}
