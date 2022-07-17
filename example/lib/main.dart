import 'package:flutter/material.dart';
import 'package:neis/neis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _neis =
      Neis(Region.chungnam, "8222021", SchoolType.els, "");
  String meal = "";

  @override
  void initState() {
    super.initState();
    _neis.getTimetables(1, 1, DateTime.now()).then((value) {
      setState(() {
        meal = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(meal),
        ),
      ),
    );
  }
}
