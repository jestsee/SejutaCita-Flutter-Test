import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/repository/issue-repository.dart';

part 'issue_event.dart';

part 'issue_state.dart';

const throttleDuration = Duration(milliseconds: 100);

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  final IssueRepo _issueRepo;
  // final String query;

  String query = "ayam";

  // initial state
  IssueBloc(this._issueRepo) : super(const IssueState()) {
    on<IssueFetchedEvent>(_onIssueFetched);
  }

  Future<void> _onIssueFetched(
      IssueFetchedEvent event, Emitter<IssueState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == IssueStatus.initial) {
        final issues = await _issueRepo.getIssues(query, 1);
        return emit(state.copyWith(
          status: IssueStatus.success,
          items: issues,
          hasReachedMax: false,
        ));
      }

      final issues = await _issueRepo.getIssues(query, 2);
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
}
