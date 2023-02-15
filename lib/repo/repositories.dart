import 'dart:convert';
import '../model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<List<UserModel>> getUsers() async {
    print('getUsers');
    final url = (Uri.parse(
        'http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts'));
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List resdata = json.decode(response.body);

       var pref = await SharedPreferences.getInstance();
       List<UserModel> listdata = resdata.map((e) => UserModel.fromJson(e)).toList();
       final string = jsonEncode(listdata);
          await pref.setString('user_list', string);

      return resdata.map((e) => UserModel.fromJson(e)).toList();
    } else {
       throw Exception('Failed');
    }
  }
}
