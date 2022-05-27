import 'dart:developer';

import 'package:sejuta_cita_test/models/repository-response.dart';

import '../constants.dart';
import '../services/http-service.dart';

class RepositoryRepo {
  Future<RepositoryResponse> getRepositories(String query, int page) async {
    log("API hit");
    final resp = await HttpService.getRequest(
        "issues?q=$query&page=$page&per_page=${Constant.LIMIT}");
    if (resp.statusCode == 200) {
      final result = repositoryFromJson(resp.body);
      return result;
    } else {
      log("NULLLL");
      throw Exception('Failed to load issues');
    }
  }
}
