import 'package:get/get.dart';
import 'package:ukuya_zakwan/controller/news_list_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewsListController>(NewsListController());
  }
}
