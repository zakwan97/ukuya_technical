import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ukuya_zakwan/controller/news_list_controller.dart';

class NewsSearchBar extends StatelessWidget {
  const NewsSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsListController>(builder: (news) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.2),
        height: 45,
        child: CupertinoSearchTextField(
          borderRadius: BorderRadius.circular(16),
          placeholder: 'Search News',
          controller: news.searchController,
          onChanged: (val) {
            news.settxtsearch(val);
          },
        ),
      );
    });
  }
}
