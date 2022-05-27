import 'dart:developer';
import 'dart:io';

import 'package:sejuta_cita_test/constants.dart';
import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/services/http-service.dart';

import '../models/repository-response.dart';
import '../models/user-response.dart';

abstract class Repo<T> {
  Future<T> getData(String query, int page);
}

class IssueRepo extends Repo{
  @override
  Future<IssueResponse> getData(String query, int page) async {
    log("API hit");
    final resp = await HttpService.getRequest(
        "issues?q=$query&page=$page&per_page=${Constant.LIMIT}");
    if (resp.statusCode == 200) {
      final result = issueFromJson(resp.body);
      return result;
    } else {
      log("NULLLL");
      throw Exception('Failed to load issues');
    }
  }
}

class RepositoryRepo extends Repo{
  @override
  Future<RepositoryResponse> getData(String query, int page) async {
    log("API hit");
    final resp = await HttpService.getRequest(
        "repositories?q=$query&page=$page&per_page=${Constant.LIMIT}");
    if (resp.statusCode == 200) {
      final result = repositoryFromJson(resp.body);
      return result;
    } else {
      log("NULLLL");
      throw Exception('Failed to load issues');
    }
  }
}

class UserRepo extends Repo{
  @override
  Future<UserResponse> getData(String query, int page) async {
    log("API hit");
    final resp = await HttpService.getRequest(
        "users?q=$query&page=$page&per_page=${Constant.LIMIT}");
    if (resp.statusCode == 200) {
      final result = userFromJson(resp.body);
      return result;
    } else {
      log("NULLLL");
      throw Exception('Failed to load issues');
    }
  }
}