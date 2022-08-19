import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ukuya_zakwan/controller/news_comment_controller.dart';
import 'package:ukuya_zakwan/controller/news_list_controller.dart';
import 'package:ukuya_zakwan/model/news_list_model.dart';

class NewsDetailPage extends StatefulWidget {
  final int id;
  const NewsDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  NewsListController nwc = Get.put(NewsListController());
  NewsCommentController ncc = Get.put(NewsCommentController());

  @override
  void initState() {
    nwc.getNewsDetails(widget.id.toString());
    ncc.getCommentList(widget.id.toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: const Text("News Page"),
                leading: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
            body: Center(
              child: (ncc.isLoading && nwc.isLoading)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: GetBuilder<NewsListController>(
                            builder: ((n) {
                              return Container(
                                  child: Column(
                                children: [
                                  const Text("Article",
                                      textAlign: TextAlign.start),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(
                                              nwc.newlist[widget.id].title ??
                                                  "null",
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            subtitle: Text(
                                              nwc.newlist[widget.id].body ??
                                                  "null",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Text("Comment"),
                                ],
                              ));
                            }),
                          ),
                        ),
                        Expanded(child: GetBuilder<NewsCommentController>(
                          builder: (controller) {
                            return Container(
                                child: ListView.builder(
                                    itemCount: controller.commentList.length,
                                    itemBuilder: ((context, index) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  controller
                                                      .commentList[index].email
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                                subtitle: Text(
                                                  controller.commentList[index]
                                                          .name ??
                                                      "null",
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })));
                          },
                        ))
                      ],
                    ),
            )));
  }
}
