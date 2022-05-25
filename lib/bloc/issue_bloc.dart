import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/repository/issue-repository.dart';

part 'issue_event.dart';

part 'issue_state.dart';

const throttleDuration = Duration(milliseconds: 100); // TODO

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  final IssueRepo _issueRepo;
  String query;

  // initial state
  IssueBloc(this._issueRepo, this.query) : super(const IssueState()) {
    on<GetIssueEvent>(_onIssueFetched);
    on<GetNewIssueEvent>(_onNewIssueFetched);
  }

  // melanjutkan dari query yang sudah ada
  Future<void> _onIssueFetched(
      GetIssueEvent event, Emitter<IssueState> emit) async {
    if (state.hasReachedMax) return;
    try {
      // TODO kalo hasil baginya desimal
      int page = state.items.length~/30;
      log("page: $page");

      final issues = await _issueRepo.getIssues(query, page+1);
      emit(issues.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: IssueStatus.success,
              items: List.of(state.items)..addAll(issues),
              hasReachedMax: false));
    } catch (_) {
      emit(state.copyWith(status: IssueStatus.failure));
    }
  }

  // memulai query baru
  Future<void> _onNewIssueFetched(
      GetNewIssueEvent event, Emitter<IssueState> emit) async {
    emit(state.copyWith(status: IssueStatus.loading));
    if (state.hasReachedMax) return;
    try {
      log("masuk initial state new issue");
      query = event.query; // set new query
      final issues = await _issueRepo.getIssues(query, 1);
      emit(state.copyWith(
        status: IssueStatus.success,
        items: issues,
        hasReachedMax: false,
      ));
    } catch (_) {
      emit(state.copyWith(status: IssueStatus.failure));
    }
  }
}
