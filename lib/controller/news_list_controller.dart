import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ukuya_zakwan/model/news_list_model.dart';
import 'package:ukuya_zakwan/services/new_api.dart';

class NewsListController extends GetxController {
  var newlist = <NewsListModel>[].obs;
  var searchnewlist = <NewsListModel>[].obs;
  var newmodel;
  var detail = <NewsListModel>[].obs;
  var isLoading = true;
  var isLoadingRegister = false;

  //Search Module
  var txtSearch = ''.obs;
  late TextEditingController searchController;

  void settxtsearch(String val) {
    txtSearch.value = val;
    searchnewlist.clear();
    filteroutlet();
    update();
  }

  //Assign to API
  @override
  void onInit() {
    getNewsList();
    super.onInit();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController = TextEditingController();
    super.dispose();
  }

  void filteroutlet() {
    for (int i = 0; i < newlist.length; i++) {
      if (newlist[i].title!.toLowerCase().contains(txtSearch.value) ||
          newlist[i].body!.contains(txtSearch.value)) {
        searchnewlist.add(newlist[i]);
      }
    }
  }

  Future<void> getNewsList() async {
    final List<NewsListModel> response = await API().getNewsList();
    newlist.value = response;
    isLoading = false;
    update();
  }

  Future<void> getNewsDetails(String id) async {
    final NewsListModel response = await API().getNewsDetail(id);
    newmodel = response;
    isLoading = false;
    update();
  }
}
