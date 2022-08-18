import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ukuya_zakwan/model/news_list_model.dart';
import 'package:ukuya_zakwan/model/comment_model.dart';
import 'package:ukuya_zakwan/model/user_model.dart';

class API extends GetxController {
  String mainUrl = "https://jsonplaceholder.typicode.com";

  Future getUrl(String url) async {
    http.Response response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    }).catchError((err) {
      throw err.toString();
    });
    return json.decode(response.body);
  }

  Future<List> getNewsList() async {
    var url = '$mainUrl/posts';
    var data;
    try {
      data = await getUrl(url);
    } catch (err) {
      print(err);
    }
    return data.map<NewsListModel>((x) => NewsListModel.fromJson(x)).toList();
  }

  Future getNewsDetail(String id) async {
    var url = '$mainUrl/posts/$id';
    var data = await getUrl(url);
    return NewsListModel.fromJson(data);
  }

  Future getComment(String postId) async {
    var url = '$mainUrl/comments?postId=$postId';
    var data = await getUrl(url);
    return data.map<CommentModel>((x) => CommentModel.fromJson(x)).toList();
  }

  Future getUserList() async {
    var url = '$mainUrl/users';
    var data = await getUrl(url);
    return data.map<UserModel>((x) => UserModel.fromJson(x)).toList();
  }
}
