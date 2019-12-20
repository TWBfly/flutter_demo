import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      home: SampleView(),
    );
  }
}

class SampleView extends StatefulWidget {
  @override
  _SampleViewState createState() => _SampleViewState();
}

class _SampleViewState extends State<SampleView> {
  static const MethodChannel _methodChannel = MethodChannel('PlatformView');

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  Future<void> _launchPlatformCount() async {
    final int platformCounter = await _methodChannel.invokeMethod('switchView', _counter);
    setState(() {
      _counter = platformCounter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter PlatformView"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
                    style: const TextStyle(fontSize: 17.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: RaisedButton(child: Platform.isIOS ? const Text('Continue in iOS view') : const Text('Continue in Android view'), onPressed: _launchPlatformCount),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 15.0, left: 5.0),
            child: Row(
              children: <Widget>[
                FlutterLogo(),
                const Text(
                  'Flutter',
                  style: TextStyle(fontSize: 30.0),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
