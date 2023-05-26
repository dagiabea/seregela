import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'items_model.dart';

class ApiService {
  Future<List<Items>?> getOrders() async {
    try {
      var url = Uri.parse('https://seregela-gebeya-default-rtdb.firebaseio.com/.json');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Items> _model = welcomeFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

//https://shipday-drive-default-rtdb.firebaseio.com/orders/0/status.json
//body "on the way or other status"

  
}
