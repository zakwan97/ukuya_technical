import 'package:get/get.dart';
import 'package:ukuya_zakwan/bindings/bindings.dart';
import 'package:ukuya_zakwan/routes/app_routes.dart';
import 'package:ukuya_zakwan/screen/news/news_list_detail_screen.dart';
import 'package:ukuya_zakwan/screen/news/news_list_screen.dart';

class AppPages {
  static const initialPage = AppRoutes.newsListScreen;
  static final pageList = [
    GetPage(
      name: AppRoutes.newsListScreen,
      page: () => const NewsListScreen(),
    ),
    // GetPage(
    //     name: AppRoutes.newsListScreen, page: (() => const NewsListScreen())),
    GetPage(
        name: AppRoutes.newsDetail,
        page: () => NewsDetailPage(id: Get.arguments),
        binding: NewsBinding()),
  ];
}
