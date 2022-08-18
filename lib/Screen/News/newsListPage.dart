import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ukuya_zakwan/Screen/News/newsListDetailPage.dart';
import 'package:ukuya_zakwan/Screen/User/userListPage.dart';
import 'package:ukuya_zakwan/services/api.dart';

final API httpService = API();

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _NewsListPageState extends State<NewsListPage> {
  final _debouncer = Debouncer();
  final TextEditingController textcontroller = TextEditingController();
  List aList = [];
  List nList = [];

  @override
  void initState() {
    super.initState();
    getList().then((data) {
      setState(() {
        aList = data;
        nList = aList;
      });
    });
  }

  getList() {
    return httpService.getNewsList();
  }

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserListPage()));
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          //Search Bar to List of typed Subject
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: textcontroller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                suffixIcon: const InkWell(
                  child: Icon(Icons.search),
                ),
                contentPadding: const EdgeInsets.all(15.0),
                hintText: 'Search ',
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    nList = aList
                        .where(
                          (u) => (u.title.toString().toLowerCase().contains(
                                string.toLowerCase(),
                              )),
                        )
                        .toList();
                  });
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(5),
              itemCount: nList.length,
              itemBuilder: (BuildContext context, int index) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            nList[index].title.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(
                            nList[index].body ?? "null",
                            style: const TextStyle(fontSize: 16),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsListDetailPage(
                                        id: nList[index].id.toString())));
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
