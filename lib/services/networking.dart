import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  Future getData(url) async {
    http.Response response = await http.get(
      Uri.parse(
        url,
      ),
    );
    var data = response.body;

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      debugPrint('error');
    }
  }
}
