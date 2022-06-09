import 'package:flutter/material.dart';
import 'package:ukuya_zakwan/webservice/api.dart';

final API httpService = API();

class NewsListDetailPage extends StatefulWidget {
  const NewsListDetailPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<NewsListDetailPage> createState() => _NewsListDetailPageState();
}

class _NewsListDetailPageState extends State<NewsListDetailPage> {
  // ignore: prefer_typing_uninitialized_variables
  var newModel;
  // ignore: prefer_typing_uninitialized_variables
  var commentModel;

  @override
  void initState() {
    super.initState();
    getNewsDetail(widget.id).then((data) {
      setState(() {
        newModel = data;
      });
    });
    getComment(widget.id).then((commentData) {
      setState(() {
        commentModel = commentData;
      });
    });
  }

  getNewsDetail(String id) {
    return httpService.getNewsDetail(id);
  }

  getComment(String postId) {
    return httpService.getComment(postId);
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
        child: (newModel != null &&
                newModel != "" &&
                commentModel != null &&
                commentModel != "")
            ? Column(
                children: [
                  const Text("Article", textAlign: TextAlign.start),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              newModel?.title ?? "null",
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              newModel?.body ?? "null",
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Text("Comment"),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.all(5),
                      itemCount: commentModel?.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    commentModel![index].name + ' email: ' + commentModel![index].email ?? "null",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    commentModel![index].body ?? "null",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    ));
  }
}
