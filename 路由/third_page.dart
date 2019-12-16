import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Third Screen"),),
      body: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("goBack Second Page"),
      ),
    );
  }
}
