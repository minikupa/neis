import 'package:flutter/material.dart';import 'package:neis/neis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _neis = Neis(Region.chungnam, "8140098", "key");
  String meal = "";

  @override
  void initState() {
    super.initState();
    _neis.getSchedules(2022, 7).then((value) {
      setState(() {
        meal = value.toString();
        print(value[0]);
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
