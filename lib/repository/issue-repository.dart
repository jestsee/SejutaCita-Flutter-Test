import 'dart:developer';
import 'dart:io';

import 'package:sejuta_cita_test/constants.dart';
import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/services/http-service.dart';

class IssueRepo {
// Mengembalikan list of issue item
  Future<DataResponse> getIssues(String query, int page) async {
    log("API hit");
    final resp = await HttpService.getRequest("issues?q=$query&page=$page&per_page=${Constant.LIMIT}");
    if (resp.statusCode == 200) {
      final result = issueFromJson(resp.body);
      return result; 
    } else {
      log("NULLLL");
      throw Exception('Failed to load issues');
    }
  }
}

// TODO repo buat user sama issue