import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HttpService {
  static const String base_URL = "https://api.github.com/search/";

  static Future<Response> getRequest(endPoint) async {
    Response resp;
    final url = Uri.parse("$base_URL$endPoint");

    log("URL: $url");

    return Future.delayed(const Duration(milliseconds: 500), () async {
      try {
        final temp = await get(url);
        resp = _returnResponse(temp);
      } on SocketException  {
        throw Exception("Please check your connection.");
      }
      return resp;
    });
  }

  static dynamic _returnResponse(Response resp) {
    switch (resp.statusCode) {
      case 200:
        return resp;
      case 403:
        throw Exception("API rate limit exceeded, please try again in a minute.");
      default:
        throw Exception("Something went wrong.");
    }
  }
}
