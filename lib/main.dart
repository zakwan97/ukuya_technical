import 'package:flutter/material.dart';
import 'package:ukuya_zakwan/Screen/News/newsListPage.dart';
import 'package:get/get.dart';
import 'package:ukuya_zakwan/controller/news_list_controller.dart';
import 'package:ukuya_zakwan/routes/app_pages.dart';
import 'package:ukuya_zakwan/routes/app_routes.dart';
import 'package:ukuya_zakwan/screen/news/news_list_screen.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsListController(), fenix: true);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

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
        // home: const NewsListPage(
        //   title: 'test',
        // ));
        navigatorObservers: const [],
        initialBinding: InitialBinding(),
        initialRoute: AppPages.initialPage,
        getPages: AppPages.pageList);
  }
}
