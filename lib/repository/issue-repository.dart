import 'dart:io';

import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/services/http-service.dart';

class IssueRepository {
  Future<List<Item>?> getIssues(String query) async {
    try {
      final resp = await HttpService.getRequest("issues?q=$query");

      if (resp.statusCode == 200) {
        final result = issueFromJson(resp.body).items;
        return result;
      } else {
        return null;
      }
    } on Exception catch (e) {
      rethrow;
    }
  }
}

// TODO repo buat user sama issue