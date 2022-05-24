import 'dart:developer';
import 'dart:io';

import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/services/http-service.dart';

class IssueRepo {
  Future<Item?> getIssues(String query) async {
    try {
      final resp = await HttpService.getRequest("issues?q=$query");

      if (resp.statusCode == 200) {
        log("ga null weh");
        final result = issueFromJson(resp.body).items;
        return result[0]; // TODO misanya item pertama dulu
      } else {
        log("NULLLL");
        return null;
      }
    } on Exception catch (e) {
      rethrow;
    }
  }
}

// TODO repo buat user sama issue