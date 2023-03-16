import 'dart:convert';

import 'package:grock/grock.dart';
import 'package:riverpod_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class MyService {
   Future<UserModel> fetch() async {
    var url = Uri.parse("https://reqres.in/api/users?page=2");
    var response;

    try {
      response = await http.get(url);
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }
}
