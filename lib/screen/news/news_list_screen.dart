import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ukuya_zakwan/controller/news_list_controller.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  NewsListController put = Get.put(NewsListController());
  NewsListController newsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'News List',
            style: TextStyle(fontSize: 25),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.people,
                color: Colors.white,
              ),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const UserListPage()));
              },
            )
          ],
        ),
        body: Container(child: GetBuilder<NewsListController>(
          builder: ((n) {
            return newsController.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: n.txtSearch.value.isEmpty
                        ? ListView.builder(
                            itemCount: n.newlist.length,
                            itemBuilder: ((context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          n.newlist[index].title.toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        subtitle: Text(
                                          n.newlist[index].body ?? "null",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        onTap: () {},
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }))
                        : ListView.builder(
                            itemCount: n.searchnewlist.length,
                            itemBuilder: ((context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          n.searchnewlist[index].title
                                              .toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        subtitle: Text(
                                          n.searchnewlist[index].body ?? "null",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        onTap: () {},
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })));
          }),
        )));
  }
}
