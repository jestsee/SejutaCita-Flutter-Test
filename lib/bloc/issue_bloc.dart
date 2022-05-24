import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sejuta_cita_test/repository/issue-repository.dart';

part 'issue_event.dart';
part 'issue_state.dart';

class IssueBloc extends Bloc<IssueEvent, IssueState> {

  final IssueRepo _issueRepo;

  IssueBloc(this._issueRepo) : super(IssueLoadingState()) {
    on<LoadIssueEvent>((event, emit) async {
      // TODO nanti querynya dinamis
      final issue = await _issueRepo.getIssues("doraemon");
      emit(IssueLoadedState(issue!.title, issue.updatedAt, issue.state));
    });
  }
}
