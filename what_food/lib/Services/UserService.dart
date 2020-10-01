import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:what_food/Models/ServerModels.dart';

class UserService {
  static Future<String> updateAvatar(urlAvatar) async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;
    String apiUrl = "$URL_UPDATEAVATAR";
    http.Response response = await http.post(apiUrl, body: {
      'image': urlAvatar,
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      print("Result: ${response.body}");
      print('update avatar thanh cong');
    } else {
      print('update avatar that bai');
    }
  }
}
