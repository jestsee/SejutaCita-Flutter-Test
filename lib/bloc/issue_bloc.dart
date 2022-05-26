import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sejuta_cita_test/constants.dart';
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
    on<GetIssueEvent>(_onIssueFetched); // TODO hapus aja kayaknya
    on<GetNewIssueEvent>(_onNewIssueFetched);
    on<GetIssueIndexEvent>(_onIssuePageFetched);
    on<IndexToLazyEvent>(_onIndexToLazy);
  }

  // melanjutkan dari query yang sudah ada
  Future<void> _onIssueFetched(
      GetIssueEvent event, Emitter<IssueState> emit) async {
    if (state.hasReachedMax) return;
    try {
      int page = state.items.length ~/ Constant.LIMIT;
      log("page: $page");

      final issues = await _issueRepo.getIssues(query, page + 1);
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
        slicedItems: issues.items,
        // ambil semuanya
        hasReachedMax: false,
        totalItems: issues.totalCount,
        currentPage: 1
      ));
    } catch (_) {
      emit(state.copyWith(status: IssueStatus.failure));
    }
  }

  // load issue pada page tertentu
  Future<void> _onIssuePageFetched(
      GetIssueIndexEvent event, Emitter<IssueState> emit) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: IssueStatus.loading));
    int _endAt = event.page * Constant.LIMIT;
    int _startAt = _endAt - Constant.LIMIT;

    // data sudah tersedia
    if (_endAt <= state.items.length &&
        state.items[_startAt].state != "unknown" &&
        state.items[_endAt - 1].state != "unknown") {
      emit(state.copyWith(
          status: IssueStatus.success,
          slicedItems: state.items.sublist(_startAt, _endAt),
          currentPage: event.page));
    }

    // data belum tersedia ; fetch dari API
    else {
      try {
        final issues = await _issueRepo.getIssues(query, event.page);
        var tempList = List.of(state.items);

        // menangani indeks yang loncat / ga berurut
        // isi dulu bolongnya
        while (tempList.length < _startAt) {
          tempList.add(Item(
              title: "unknown",
              state: "unknown",
              createdAt: DateTime.utc(0),
              updatedAt: DateTime.utc(0)));
        }

        // baru tambahin hasil fetch
        tempList.addAll(issues.items);

        // replace unknown data
        if (tempList[_startAt].state == "unknown" &&
            tempList[_endAt - 1].state == "unknown") {
          log("masuk replace data baru");
          tempList.replaceRange(_startAt, _endAt, issues.items);
        }

        var tempSlicedList = tempList.sublist(_endAt - Constant.LIMIT, _endAt);

        log("startAt: $_startAt endAt: $_endAt current length: ${tempList.length}");

        emit(issues.items.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: IssueStatus.success,
                items: tempList,
                slicedItems: tempSlicedList,
                currentPage: event.page,
                hasReachedMax: false,
              ));
      } catch (e) {
        log("ERROR: $e");
        emit(state.copyWith(status: IssueStatus.failure));
      }
    }
  }

  // pindah dari index ke lazy
  Future<void> _onIndexToLazy(
      IndexToLazyEvent event, Emitter<IssueState> emit) async {
    emit(state.copyWith(currentIdx: event.idx, currentPage: event.page));
  }
}
