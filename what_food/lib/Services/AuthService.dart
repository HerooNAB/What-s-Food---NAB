import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_food/Models/ServerModels.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:what_food/Models/UserModel.dart';

class AuthService {
  static Future<String> signup_Author(phone, password, email, name) async {
    String apiUrl = '$URL_SIGNUP';
    http.Response response = await http.post(apiUrl, body: {
      'phone': phone,
      'password': password,
      'email': email,
      'name': name
    });
    if (response.statusCode == 200) {
      print("Result: ${response.body}");
      print('danh ky thanh cong');
      return "1";
    } else {
      print('dang ky that bai');
      return "0";
    }
  }

  static Future<String> login_Author(phone, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiUrl = '$URL_LOGIN';
    var jsonResponseToken;
    var jsonResponseId;
    http.Response response =
        await http.post(apiUrl, body: {'phone': phone, 'password': password});
    if (response.statusCode == 200) {
      jsonResponseToken = json.decode(response.body);
      sharedPreferences.setString("token", jsonResponseToken['token']);
      jsonResponseId = json.decode(response.body);
      sharedPreferences.setString("id", jsonResponseId['_id']);
      print('danh nhap thanh cong');
      print(jsonResponseToken);
      print(jsonResponseId);
      return "1";
    } else {
      print('dang nhap that bai');
      return "0";
    }
  }

  static Future<User> profile_Author() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String apiUrl = '$URL_PROFILE';
    http.Response response =
        await http.get(apiUrl, headers: {'Authorization': 'Bearer $value'});
    if (response.statusCode == 200) {
      print("test git");
      return User.fromJson(json.decode(response.body));
    } else {
      print('Lấy Profile Về Thất Bại');
      return null;
    }
  }

  static Future<User> getUserWithId(idUser) async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;

    String apiUrl = '$URL_USERWITHID$idUser';
    http.Response response =
        await http.get(apiUrl, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      print("Result: ${response.body}");
      print('Lấy User Về Thành Công');
      return User.fromJson(json.decode(response.body));
    } else {
      print('Lấy User Về Thất Bại');
      throw Exception('Lấy User Về Thất Bại');
    }
  }

  static Future<User> upDateProfileUser(name, email, bio, avatar) async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;

    String apiUrl = '$URL_UPDATEPROFILE';
    http.Response response = await http.put(apiUrl,
        body: {'name': name, 'email': email, 'bio': bio, 'avatar': avatar},
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      print("Result: ${response.body}");
      print('Up Date Thành Công');
      return json.decode(response.body);
    } else {
      print('Up Date Thất Bại');
      return null;
    }
  }

  static Future logout_Author() async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;

    String apiUrl = '$URL_LOGOUT';
    http.Response response =
        await http.post(apiUrl, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      print('Dang xuat thanh cong');
    }
    return true;
  }
}
