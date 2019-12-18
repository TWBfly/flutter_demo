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
  Future<Database> database;

  List<Student> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DB Demo"),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                create();
              },
              child: Text("create"),
            ),
            RaisedButton(
              onPressed: () {
                insert();
              },
              child: Text("insert"),
            ),
            RaisedButton(
              onPressed: () {
                delete();
              },
              child: Text("delete"),
            ),
            RaisedButton(
              onPressed: () {
                update();
              },
              child: Text("update"),
            ),
            RaisedButton(
              onPressed: () {
                query();
              },
              child: Text("query"),
            ),
            Text("$list"),
          ],
        ));
  }

  Future<void> create() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'students_database.db'),
      onCreate: (db, version) => db.execute("CREATE TABLE students(id TEXT PRIMARY KEY, name TEXT, score INTEGER)"),
      onUpgrade: (db, oldVersion, newVersion) {
        //升级
        //dosth for migration
      },
      version: 1,
    );
  }

  //增
  Future<void> insert() async {
    var student1 = Student(id: '123', name: '张三', score: 90);
    var student2 = Student(id: '456', name: '李四', score: 80);
    var student3 = Student(id: '789', name: '王五', score: 85);
    Future<void> insertStudent(Student std) async {
      final Database db = await database;
      await db.insert(
        'students', std.toJson(), //插入冲突策略，新的替换旧的
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    //插入3个Student对象
    await insertStudent(student1);
    await insertStudent(student2);
    await insertStudent(student3);
  }

  //删
  Future<void> delete() async {
    Future<void> deleteStudent(String id) async {
      final Database db = await database;
      //      await db.delete("students",where: "id=?",whereArgs:[id] );
      await db.rawDelete('DELETE FROM students WHERE id = ?', ['$id']);
    }
    //删除id=123
    await deleteStudent("123");
  }

  //改
  Future<void> update() async{
    Future<void> updateStudent(String newName,int score,String oldName) async {
      final Database db = await database;
      await db.rawUpdate('UPDATE students SET name = ?, score = ? WHERE name = ?', ['$newName','$score','$oldName']);
    }

    await updateStudent("张xiao三",123456,"张三");
  }

  //查
  Future<void> query() async {
    Future<List<Student>> students() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('students');
      return List.generate(maps.length, (i) => Student.fromJson(maps[i]));
    }

    //读取出数据库中插入的Student对象集合
    //    students().then((list)=>list.forEach((s)=> print(s.name)));
    students().then((value) {
      setState(() {});
      list = value;
      value.forEach((s) {
        print(s.name);
      });
    });

  }

  @override
  void dispose() {
    db_close();
    super.dispose();
  }

  Future<void> db_close() async {
    //释放数据库资源
    final Database db = await database;
    db.close();
  }
}

class Student {
  String id;
  String name;
  int score;

  //构造方法
  Student({
    this.id,
    this.name,
    this.score,
  });

  //用于将JSON字典转换成类对象的工厂类方法
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
      id: parsedJson['id'],
      name: parsedJson['name'],
      score: parsedJson['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'score': score,
    };
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name, score: $score}';
  }
}
