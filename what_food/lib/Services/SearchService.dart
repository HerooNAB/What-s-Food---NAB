import 'package:http/http.dart' as http;
import 'package:what_food/Models/ServerModels.dart';

class SearchService {
  static Future<String> search_bag(item) async {
    print("testsearch1");
    String apiUrl = '$URL_SEARCHBAG';
    print(item);
    Map<String, String> queryParams = {'item': item};
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = apiUrl + '?' + queryString;
    http.Response response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      print("testsearch4");
      print("Result: ${response.body}");
      print('search thanh cong');
    } else {
      print('search that bai');
    }
  }
}
