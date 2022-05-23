import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HttpService {
  static const String base_URL = "https://api.github.com/search/";

  static Future<Response> getRequest(endPoint) async {
    Response resp;
    final url = Uri.parse("$base_URL$endPoint");

    try {
      resp = await get(url);
    } on Exception catch (e) {
      rethrow;
    }

    return resp;
  }
}