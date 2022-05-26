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
    on<GetIssueEvent>(_onIssueFetched);
    on<GetNewIssueEvent>(_onNewIssueFetched);
    on<GetIssueIndexEvent>(_onIssuePageFetched);
  }

  // melanjutkan dari query yang sudah ada
  Future<void> _onIssueFetched(
      GetIssueEvent event, Emitter<IssueState> emit) async {
    if (state.hasReachedMax) return;
    try {
      int page = state.items.length ~/ 30;
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
      ));
    } catch (_) {
      emit(state.copyWith(status: IssueStatus.failure));
    }
  }

  // load issue pada page tertentu
  Future<void> _onIssuePageFetched(
      GetIssueIndexEvent event, Emitter<IssueState> emit) async {
    if (state.hasReachedMax) return;

    // TODO tinggal convert aja dari lazy ke index
    if (event.page == -1) {
      log("masuk event page = -1");

      // track dulu sekarang lagi di index berapa
      // ...

      emit(state.copyWith(
          items: state.items,
          slicedItems: state.items, // TODO di-slice berdasarkan index berapa
          status: IssueStatus.success));
    }

    // kalo datanya udah tersedia ga perlu fetch dari api lagi
    else {
      emit(state.copyWith(status: IssueStatus.loading));
      int _endAt = event.page * Constant.LIMIT;
      int _startAt = _endAt - Constant.LIMIT;

      // data sudah tersedia
      if (_endAt <= state.items.length
          && state.items[_startAt].state != "unknown"
          && state.items[_endAt-1].state != "unknown"
      ) {
        emit(state.copyWith(
            status: IssueStatus.success,
            slicedItems: state.items.sublist(_startAt, _endAt)));
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
                updatedAt: DateTime.utc(0)
            ));
          }

          // baru tambahin hasil fetch
          tempList.addAll(issues.items);

          // replace unknown data
          if (tempList[_startAt].state == "unknown"
              && tempList[_endAt-1].state == "unknown") {
            log("masuk replace data baru");
            tempList.replaceRange(_startAt, _endAt, issues.items);
          }

          var tempSlicedList =
              tempList.sublist(_endAt - Constant.LIMIT, _endAt);

          log("startAt: $_startAt endAt: $_endAt current length: ${tempList.length}");

          emit(issues.items.isEmpty
              ? state.copyWith(hasReachedMax: true)
              : state.copyWith(
                  status: IssueStatus.success,
                  items: tempList,
                  slicedItems: tempSlicedList,
                  hasReachedMax: false,
                  endAt: event.page * Constant.LIMIT,
                ));
        } catch (e) {
          log("ERROR: $e");
          emit(state.copyWith(status: IssueStatus.failure));
        }
      }

      // TODO bisa dikeluarin emitnya, tinggal persoalan perlu fetch lagi apa ngga
    }
  }
}
