import 'dart:developer';
import 'dart:io';

import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/services/http-service.dart';

class IssueRepo {
  Future<List<Item>> getIssues(String query) async {
    final resp = await HttpService.getRequest("issues?q=$query");

    if (resp.statusCode == 200) {
      log("ga null weh");
      final result = issueFromJson(resp.body);
      return result.items; // TODO misanya item pertama dulu
    } else {
      log("NULLLL");
      throw Exception('Failed to load issues');
    }
  }
}

// TODO repo buat user sama issue