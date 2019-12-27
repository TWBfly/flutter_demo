import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/second_page.dart';
import 'package:flutter_app_test/third_page.dart';
import 'package:flutter_app_test/un_known_page.dart';

import 'custom_loading_dialog.dart';
import 'loading_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', //主题颜色
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dialog"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("SimpleDialog"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return SimpleDialog(
                      title: Text("标题SimpleDialog"),
                      children: <Widget>[
                        Container(
                          height: 100,
                          child: Text('这里是内容'),
                        ),
                        RaisedButton(
                          child: Text('取消'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        RaisedButton(
                          child: Text('确认'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          RaisedButton(
            child: Text("AlertDialog"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text("标题AlertDialog"),
                      content: Text("这里是内容"),
                      actions: <Widget>[
                        RaisedButton(
                          child: Text('取消'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        RaisedButton(
                          child: Text('确定'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          RaisedButton(
            child: Text("GeneralDialog"),
            onPressed: () {
              showGeneralDialog(
                  context: context,
                  barrierDismissible: false,
                  barrierLabel: 'barrierLabel',
                  transitionDuration: Duration(milliseconds: 400),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AlertDialog(
                      title: Text("标题GeneralDialog"),
                      content: Text("这里是内容"),
                      actions: <Widget>[
                        RaisedButton(
                          child: Text('取消'),
                          onPressed: () {
//                            Navigator.of(context).pop();
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                        RaisedButton(
                          child: Text('确定'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),

          RaisedButton(
            child: Text("CupertinoAlertDialog"),
            onPressed: (){
              showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return  CupertinoAlertDialog(
                      title:  Text("标题 CupertinoAlertDialog"),
                      content:  Text("内容内容内容内容内容内容内容内容内容内容内容"),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop("点击了确定");
                          },
                          child:  Text("确认"),
                        ),
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop("点击了取消");
                          },
                          child: Text("取消"),
                        ),
                      ],
                    );
                  });
            },
          ),
          ///fix error overflow
          RaisedButton(
            child: Text("DialogWithColumn"),
            onPressed: (){
              showDialogWithColumn(context);
            },
          ),

          RaisedButton(
            child: Text("DialogWithListView"),
            onPressed: (){
              showDialogWithListView(context);
            },
          ),
          RaisedButton(
            child: Text("showDialogWithStateBuilder"),
            onPressed: (){
              showDialogWithStateBuilder(context);
            },
          ),
          RaisedButton(
            child: Text("自定义Dialog"),
            onPressed: (){
              showCustomLoadingDialog(context);
            },
          ),
          ///许可证 dialog 样式固定
          RaisedButton(
            child: Text("AboutDialog"),
            onPressed: (){
              showAboutDialog(context: context,children: [
                Padding(padding: EdgeInsets.only(top: 10.0), child: Text('1. AboutDialog!')),
                Padding(padding: EdgeInsets.only(top: 10.0), child: Text('2. SimpleDialog!')),
                Padding(padding: EdgeInsets.only(top: 10.0), child: Text('3. AlertDialog!'))
              ]);
//              showDialog(context: context,
//                  barrierDismissible: false,
//                  builder: (context) {
//                    return AboutDialog(
//                        applicationIcon: Container(child: FlutterLogo()),
//                        applicationName: 'Flutter Dialog',
//                        applicationLegalese: '所有解释权归本人所有！',
//                        applicationVersion: 'V1.5.2',
//                        children: <Widget>[
//                          Padding(padding: EdgeInsets.only(top: 10.0), child: Text('1. AboutDialog!')),
//                          Padding(padding: EdgeInsets.only(top: 10.0), child: Text('2. SimpleDialog!')),
//                          Padding(padding: EdgeInsets.only(top: 10.0), child: Text('3. AlertDialog!'))
//                        ]);
//                  });
            },
          ),


          RaisedButton(
            onPressed: () {

          },
            child: Text("sheetDialog"),
          ),
        ],
      ),
        //Scaffold.of() called with a context that does not contain a Scaffold.
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(onPressed: () {
          showBottomSheet(context: context, builder: (_){
            return Container(
              height: 200,
              width: 200,
              color: Colors.red,
              child: Column(
                children: <Widget>[
                  Text("相册1"),
                  Text("拍照1"),
                  Text("取消1"),
                ],
              ),
            );
          });

//          Scaffold.of(context).showBottomSheet((_){
//            return Container(
//              height: 200,
//              width: 200,
//              child: Column(
//                children: <Widget>[
//                  Text("相册"),
//                  Text("拍照"),
//                  Text("取消"),
//                ],
//              ),
//            );
//          });
        },);
      },)

    );
  }


  void showDialogWithColumn(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("title"),
            content: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                  new SizedBox(
                    height: 100,
                    child: new Text("1"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {Navigator.of(context).pop();},
                child: Text("确认"),
              ),
              new FlatButton(
                onPressed: () {Navigator.of(context).pop();},
                child: Text("取消"),
              ),
            ],
          );
        });
  }

  void showDialogWithListView(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Listview"),
            content: Container(
              /*
              要将ListView包装在具有特定宽度和高度的Container中
              如果Container没有定义这两个属性的话，会报错，无法显示ListView
               */
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return  SizedBox(
                    height: 100,
                    child:  Text("1"),
                  );
                },
                itemCount: 10,
                shrinkWrap: true,
              ),
            ));
      },
    );
}

  void showDialogWithStateBuilder(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          bool selected = false;
          return AlertDialog(
            title: Text("StatefulBuilder"),
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return Container(
                child:  CheckboxListTile(
                    title: Text("选项"),
                    value: selected,
                    onChanged: (bool) {
                      setState(() {
                        selected = !selected;
                      });
                    }),
              );
            }),
          );
        });
  }

  void showCustomLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
//          return CustomLoadingDialog();
          return LoadingDialog(text: "自定义加载中...",);
        });
  }
}
