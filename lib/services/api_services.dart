import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gallary_task/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods':
    'GET,PUT,POST,DELETE'
  };

  Future<dynamic> get() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(
        "$apiEndPoint/api/?key=$apiKey&image_type=photo");
    try {
      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        var itemCount = jsonResponse['totalItems'];
        print('Number of books about http: $itemCount.');
        return jsonResponse;
      } else {
        throw Future.error("error");
      }
    } catch (e) {
      debugPrint("catch error::: $e");
      throw e;
    }
  }

  Future<dynamic> post(Object? body, Encoding? encoding) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse("$apiEndPoint/post");
    try {
      // Await the http get response, then decode the json-formatted response.
      var response = await http.post(url,
          body: body, headers: headers, encoding: encoding);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        var itemCount = jsonResponse['totalItems'];
        print('Number of books about http: $itemCount.');
        return jsonResponse;
      } else {
        throw Future.error("error");
      }
    } catch (e) {
      debugPrint("catch error::: $e");
      throw e;
    }
  }
}
