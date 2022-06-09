import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:ukuya_zakwan/model/NewsListModel.dart';
import 'package:ukuya_zakwan/model/commentModel.dart';
import 'package:ukuya_zakwan/model/userModel.dart';

class API {
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
    // ignore: prefer_typing_uninitialized_variables
    var data;
    try {
      data = await getUrl(url);
    } catch (err) {
      // ignore: avoid_print
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
