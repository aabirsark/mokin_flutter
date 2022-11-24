import 'package:dio/dio.dart';
import 'package:mokingbird_flutter/app/constant.dart';
import 'package:mokingbird_flutter/services/api/api.serve.dart';
import 'package:mokingbird_flutter/services/local/shared_prefs.serv.dart';
import 'package:mokingbird_flutter/services/models/profile.model.dart';

class AuthService {
  static final Dio dioClient = Dio();

  static login(String username, String password) async {
    try {
      final res = await dioClient
          .post(Api.login, data: {"username": username, "password": password});
      if (res.statusCode == 201) {
        LocalStorage.saveAuthInfo(
            username: username,
            name: res.data['name'],
            jwt: res.data['access_token'],
            refresh: res.data['refresh']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static register(String username, String password, String name) async {
    try {
      final res = await dioClient.post(
        Api.signUp,
        data: {
          "username": username,
          "name": name,
          "password": password,
        },
      );

      if (res.statusCode == 201) {
        LocalStorage.saveAuthInfo(
            username: username,
            name: name,
            jwt: res.data['access_token'],
            refresh: res.data['refresh']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static refresh() async {
    try {
      final res = await dioClient.post(Api.refresh,
          data: {"refresh": LocalStorage.prefs.getString(refreshkey)});
      if (res.statusCode == 201) {
        LocalStorage.prefs.setString(jwtKey, res.data["access_token"]);
        LocalStorage.prefs.setString(refreshkey, res.data["refresh"]);
      }
    } catch (err) {
      print(err);
    }
  }

  static logout() async {
    try {
      final res = await dioClient.post(Api.logout,
          options: Options(headers: {
            'Authorization': 'Bearer ${LocalStorage.prefs.getString(jwtKey)}',
          }));
    } on DioError catch (err) {
      // if token is expired then refresh the token and re-request the api
      if (err.response?.statusCode == 401) {
        await refresh();
        final res = logout();
        return res;
      }
      return null;
    }
    {}
  }

  static profile() async {
    try {
      final res = await dioClient.get(Api.profile,
          options: Options(headers: {
            'Authorization': 'Bearer ${LocalStorage.prefs.getString(jwtKey)}',
          }));
      if (res.statusCode == 200) {
        final userProfile = Profile.fromJson(res.data);
        return userProfile;
      }
      return null;
    } on DioError catch (err) {
      // if token is expired then refresh the token and re-request the api
      if (err.response?.statusCode == 401) {
        await refresh();
        final res = profile();
        return res;
      }
      return null;
    }
  }

  static getAnotherProfile(int id) async {
    try {
      final res = await dioClient.get(
        Api.userPofile(id),
      );
      if (res.statusCode == 200) {
        final userProfile = Profile.fromJson(res.data);
        return userProfile;
      }
      return null;
    } catch (err) {
      print(err);
    }
  }

  static addUserInfo(
      {String? email, String? address, String? phone, String? bio}) async {
    try {
      final res = await dioClient.post(Api.addInfo,
          data: {
            "email": email,
            "address": address,
            "phone": phone,
            "bio": bio,
          },
          options: Options(headers: {
            'Authorization': 'Bearer ${LocalStorage.prefs.getString(jwtKey)}',
          }));
      print(res.data);
      if (res.statusCode == 201) {
        return true;
      }
      return false;
    } on DioError catch (err) {
      // if token is expired then refresh the token and re-request the api
      if (err.response?.statusCode == 401) {
        await refresh();
        final res =
            addUserInfo(email: email, address: address, phone: phone, bio: bio);
        return res;
      }
      return false;
    }
  }
}
