import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int counter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SharedPreferences Demo"),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setSP();
              },
              child: Text("set 123456"),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {});
                getSP();
              },
              child: Text("counter: ${counter??0}"),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {});
                clearSp().then((_)=>getSP());
              },
              child: Text("清除SP"),
            )
          ],
        ));
  }

  setSP() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setInt('counter', 123456);
    print("setSP");
  }

  getSP() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    counter = sp.getInt("counter") ?? 0;
    print("getSP:$counter");
    return counter;
  }

  clearSp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}
