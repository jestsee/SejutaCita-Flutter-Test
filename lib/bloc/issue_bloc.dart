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
    on<GetIssueIndexEvent>(_onIssuePageFetched);
  }

  // melanjutkan dari query yang sudah ada
  Future<void> _onIssueFetched(
      GetIssueEvent event, Emitter<IssueState> emit) async {
    if (state.hasReachedMax) return;
    try {
      int page = state.items.length~/30;
      log("page: $page");

      final issues = await _issueRepo.getIssues(query, page+1);
      emit(issues.items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: IssueStatus.success,
              items: List.of(state.items)..addAll(issues.items),
              hasReachedMax: false));
    } catch (_) {
      emit(state.copyWith(status: IssueStatus.failure));
    }
  }

  // memulai query baru
  Future<void> _onNewIssueFetched(
      GetNewIssueEvent event, Emitter<IssueState> emit) async {

    // menampilkan circular indicator
    emit(state.copyWith(status: IssueStatus.loading));

    if (state.hasReachedMax) return;
    try {
      log("masuk initial state new issue");
      query = event.query; // set new query
      final issues = await _issueRepo.getIssues(query, 1);
      emit(state.copyWith(
        status: IssueStatus.success,
        items: issues.items,
        slicedItems: issues.items, // ambil semuanya
        hasReachedMax: false,
        totalItems: issues.totalCount,
      ));
    } catch (_) {
      emit(state.copyWith(status: IssueStatus.failure));
    }
  }

  // load issue pada page tertentu
  // kalo datanya udah tersedia ga perlu fetch dari api lagi
  Future<void> _onIssuePageFetched(
      GetIssueIndexEvent event, Emitter<IssueState> emit) async {

    if (state.hasReachedMax) return;

    // tinggal convert aja dari lazy ke index
    if (event.page == -1) {
      log("masuk event page = -1");
      emit(state.copyWith(
        items: state.items,
        slicedItems: state.items,
        status: IssueStatus.success
      ));
    } else {
      try {
        final issues = await _issueRepo.getIssues(query, event.page);
        emit(issues.items.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
            status: IssueStatus.success,
            items: List.of(state.items)..addAll(issues.items),
            slicedItems: List.of(state.items)..addAll(issues.items),
            hasReachedMax: false));
      } catch (_) {
        emit(state.copyWith(status: IssueStatus.failure));
      }
    }
  }
}
