import 'package:flutter/material.dart';
import 'package:ukuya_zakwan/Screen/News/newsListPage.dart';
import 'package:get/get.dart';
import 'package:ukuya_zakwan/screen/news/news_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const NewsListScreen(),
    );
  }
}
