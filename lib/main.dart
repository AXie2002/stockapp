import 'package:flutter/material.dart';
import 'second_page.dart';
import 'third_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'localdb.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    LocalDB.loadAllStocks();

    // http.Response res = await http.get(Uri.parse('https://alexxieprojectml.sunyu912.repl.co/get-all-stocks'));
    // LocalDB.all_stocks = jsonDecode(res.body);
    // print(LocalDB.all_stocks);

    http.Response res2 = await http.get(Uri.parse('https://alexxieprojectml.sunyu912.repl.co/get-trending-stocks'));
    LocalDB.all_stocks_trending = jsonDecode(res2.body);
    print(LocalDB.all_stocks_trending);

    print("Loading the watchlist...");
    LocalDB.initPrefs();

    new Future.delayed(
        const Duration(seconds: 2),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MySecondPage(title: 'Page #2')),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/applogo.png"),
            const Text(
              'The True Social Trend on Your Investment',
            ),
            SizedBox(height: 150),
            Text(
              'Copyright @ Alex Xie, 2022'
            )
          ],
        ),
      ),
    );
  }
}
