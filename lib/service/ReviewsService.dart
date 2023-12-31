import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:save_children_v01/service/PostsService.dart';

import '../model/BMemberModel.dart';
import '../model/PostModel.dart';
import '../model/ReviewModel.dart';
import 'AlertService.dart';
// import 'ViewPostingService.dart';

class PostReview {
  int review_id;
  Post post;
  String? review_img;
  String review_txt;
  DateTime review_date;

  PostReview({
    required this.review_id,
    required this.post,
    required this.review_img,
    required this.review_txt,
    required this.review_date,
  });
}

class ReviewsService extends ChangeNotifier {
  List<Review> reviewsList = [];
  late BMember _bMember;

  Review? review_of_post;

  ReviewsService() {}

  void getMyReviews(String bMember_Id) async {
    Response res = await Dio().get(
      "http://15.165.106.139:8080/review/findMyReview/" + bMember_Id,
    );
    reviewsList.clear();
    for (Map<String, dynamic> item in res.data) {
      Review rev = Review.fromJson(item);
      reviewsList.add(rev);
    }

    notifyListeners();
  }

  void writeReview(String bMember_id, PostReview postReview) async {
    PostsService postsService = PostsService();
    print("포스트 아이디" + postReview.post.postId.toString());
    await postsService.viewPost(postReview.post);
    Post? post = postsService.aPost;
    List<String> sTokens = [];
    for (int i = 0; i < (post!.spon == null ? 1 : post.spon!.length); i++) {
      print(post.spon![i].smember == null
          ? ""
          : post.spon![i].smember!.smemberId!);
      if (post.spon![i].smember != null) {
        sTokens.add(post.spon![i].smember!.token!);
      }
    }
    final data = FormData.fromMap({
      'img': await MultipartFile.fromFile(
        postReview.review_img!,
        contentType: MediaType.parse('multipart/form-data'),
      ),
      'reviewTxt': MultipartFile.fromString(
        postReview.review_txt,
        contentType: MediaType.parse('application/json'),
      ),
    });
    try {
      Response response = await Dio().post(
        "http://15.165.106.139:8080/review/create/${postReview.post.postId}",
        data: data,
      );
      if (response.statusCode == 200) {
        // 업로드 성공 시 처리
        print('리뷰 POST 성공');
        print(response.data);
        for (int i = 0; i < sTokens.length; i++) {
          await pushAlert(sTokens[i], postReview.post.bmember!.bMember_id!,
              postReview.post.postId.toString(), "리뷰 등록");
        }
      } else {
        // 업로드 실패 시 처리
        print('업로드 실패');
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('리뷰 POST 에러');
      print(e.toString());
    }
    getMyReviews(bMember_id);
  }

  Future<void> getReviewOfPost(int post_id) async {
    Response res = await Dio().get(
      "http://15.165.106.139:8080/viewPosting/" + post_id.toString(),
    );

    Map<String, dynamic> data = res.data["review"];

    review_of_post = Review.fromJson(data);
  }
}
