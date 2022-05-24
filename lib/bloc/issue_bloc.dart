import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/repository/issue-repository.dart';
import 'package:sejuta_cita_test/services/connectivity-service.dart';

part 'issue_event.dart';
part 'issue_state.dart';

class IssueBloc extends Bloc<IssueEvent, IssueState> {

  final IssueRepo _issueRepo;
  final ConnectivityService _connectivityService;

  IssueBloc(this._issueRepo, this._connectivityService) : super(IssueLoadingState()) {

    _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        log("no internet");
        add(NoInternetEvent());
      } else {
        log("yes internet");
        add(LoadIssueEvent());
      }
    });

    on<LoadIssueEvent>((event, emit) {
      emit(IssueLoadingState());

      // TODO nanti querynya dinamis
      final issues = _issueRepo.getIssues("ayam");
      emit(IssueLoadedState(issues));
    });

    on<NoInternetEvent>((event, emit) {
      emit(IssueNoInternetState());
    });
  }
}
