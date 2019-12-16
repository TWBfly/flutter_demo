import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String firstTitle;
  final List firstList;
  const SecondPage({Key key, this.firstTitle,this.firstList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print("firstTitle:$firstTitle"+"  firstList:$firstList");

    //取出路由参数
    List msg = ModalRoute.of(context).settings.arguments as List;
    List list = ["secondpage","第二个页面",true];
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
//              Navigator.pop(context,"第second_page关闭返回的");
              Navigator.pop(context,list);
            },
            child: Text("goBack First Page"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, "third_page");
            },
            child: Text("Push Third Page"),
          ),
          Text("传递的参数:$msg"),
        ],
      )
    );
  }

}
