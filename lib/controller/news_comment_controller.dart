import 'package:get/get.dart';
import 'package:ukuya_zakwan/model/comment_model.dart';
import 'package:ukuya_zakwan/services/new_api.dart';

class NewsCommentController extends GetxController {
  var commentList = <CommentModel>[].obs;
  var isLoading = true;

  Future<void> getCommentList(String id) async {
    final List<CommentModel> response = await API().getComment(id);
    commentList.value = response;
    isLoading = false;
    update();
  }
}
