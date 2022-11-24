import 'package:dio/dio.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/api.serve.dart';
import 'package:mokingbird_flutter/services/api/auth_api.serv.dart';
import 'package:mokingbird_flutter/services/local/shared_prefs.serv.dart';
import 'package:mokingbird_flutter/services/models/activity.model.dart';
import 'package:mokingbird_flutter/services/models/comment.model.dart';
import 'package:mokingbird_flutter/services/models/thought.model.dart';

class ThoughtAPIService {
  static final Dio dioClient = Dio();

  static createNewThought(String thought) async {
    try {
      final res = await dioClient.post(Api.newThought,
          data: {"thought": thought},
          options: Options(headers: {
            'Authorization': 'Bearer ${LocalStorage.prefs.getString(jwtKey)}',
          }));
      if (res.statusCode == 201) {
        return true;
      }

      return false;
    } on DioError catch (err) {
      if (err.response?.statusCode == 401) {
        await AuthService.refresh();
        final res = createNewThought(thought);
        return res;
      }
      return false;
    }
  }

  static getAllThought() async {
    try {
      final res = await dioClient.get(Api.getAll);

      if (res.statusCode == 200) {
        List<ThoughtModel> data = [];

        for (var element in res.data) {
          data.add(ThoughtModel.fromJson(element));
        }

        return data;
      }
    } catch (err) {
      print(err);
    }
  }

  static likePost(int rootUserId, int postId) async {
    try {
      final res = await dioClient.post(Api.like,
          data: {"rootUserId": rootUserId, "postId": postId},
          options: Options(headers: {
            'Authorization': 'Bearer ${LocalStorage.prefs.getString(jwtKey)}',
          }));

      if (res.statusCode == 201) {
        return true;
      }

      return false;
    } on DioError catch (err) {
      if (err.response?.statusCode == 401) {
        await AuthService.refresh();
        final res = likePost(rootUserId, postId);
        return res;
      }
      return false;
    } catch (err) {
      print(err);
      return false;
    }
  }

  static Future<List<Comment>> getComments(int postId) async {
    // final res = await dioClient.get(Api.comments(postId));
    // print(res.statusCode);
    // return [];
    try {
      final res = await dioClient.get(Api.comments(postId));
      if (res.statusCode == 200) {
        List<Comment> comments = [];
        for (var comment in res.data) {
          print(comment);
          comments.add(Comment.fromJson(comment));
        }
        print(comments.length);
        return comments;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  static commentOnPost(int root, int postId, String value) async {
    try {
      final res = await dioClient.post(Api.comment,
          data: {"rootUserId": root, "postId": postId, "value": value},
          options: Options(headers: {
            'Authorization': 'Bearer ${LocalStorage.prefs.getString(jwtKey)}',
          }));

      if (res.statusCode == 201) {
        return true;
      }

      return false;
    } on DioError catch (err) {
      if (err.response?.statusCode == 401) {
        await AuthService.refresh();
        final res = commentOnPost(root, postId, value);
        return res;
      }
      return false;
    } catch (err) {
      print(err);
      return false;
    }
  }

  static getActivites() async {
    try {
      final res = await dioClient.get(Api.getActivites,
          options: Options(headers: {
            'Authorization': 'Bearer ${LocalStorage.prefs.getString(jwtKey)}',
          }));

      print(res.data);
      if (res.statusCode == 200) {
        List<Activity> activites = [];

        for (var element in res.data) {
          activites.add(Activity.fromJson(element));
        }

        return activites;
      }

      return false;
    } on DioError catch (err) {
      if (err.response?.statusCode == 401) {
        await AuthService.refresh();
        final res = getActivites();
        return res;
      }
      return null;
    } catch (err) {
      print(err);
      return null;
    }
  }
}
