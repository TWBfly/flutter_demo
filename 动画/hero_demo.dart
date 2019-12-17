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
      home: Page1(),
    );
  }
}
class Page1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text("Page1"),),
        body: GestureDetector(//手势监听点击
          child: Hero(
              tag: 'hero',//设置共享tag
              child: Center(
                 child:Container(
                      width: 100, height: 100,
                      child: FlutterLogo())),
              ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Page2()));//点击后打开第二个页面
          },
        )
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Page2"),),
        body: Hero(
            tag: 'hero',//设置共享tag
            child: Center(
              child: Container(
                  width: 300, height: 300,
                  child: FlutterLogo()
              ),
            ),
    )
    );
  }
}