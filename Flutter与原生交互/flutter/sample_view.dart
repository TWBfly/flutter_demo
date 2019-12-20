import 'package:flutter/foundation.dart';
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
      home: SampleView(),
    );
  }
}

class SampleView extends StatefulWidget {
  @override
  _SampleViewState createState() => _SampleViewState();
}

class _SampleViewState extends State<SampleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter 嵌套原生View"),),
      body: defaultTargetPlatform == TargetPlatform.android ? AndroidView(viewType: 'sampleView') : UiKitView(viewType: 'sampleView'),
    );
  }
}
