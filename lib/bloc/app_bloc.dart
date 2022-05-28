import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sejuta_cita_test/constants.dart';
import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/repository/repository.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  // final _issueRepo = IssueRepo();
  Repo repo;
  String query;

  // initial state
  AppBloc(this.repo, this.query)
      : super(const AppState(slicedItems: [], items: [])) {
    on<LoadDataEvent>(_onLoadData);
    on<NewQueryEvent>(_onNewQuery);
    on<LoadDataPageEvent>(_onLoadDataPage);
    on<IndexToLazyEvent>(_onIndexToLazy);
    on<ChangeSearchTypeEvent>(_onChangeSearchType);
  }

  // ganti search type
  Future<void> _onChangeSearchType(
      ChangeSearchTypeEvent event, Emitter<AppState> emit) async {
    log("CHANGE SEARCH TYPE, STATUS: ${state.status}");
    switch (event.type) {
      case SearchType.issues:
        repo = IssueRepo();
        break;
      case SearchType.repositories:
        repo = RepositoryRepo();
        break;
      default:
        repo = UserRepo();
        break;
    }
    emit(state.copyWith(type: event.type, status: Status.success));
    // add(NewQueryEvent(state.query));
  }

  // melanjutkan dari query yang sudah ada
  Future<void> _onLoadData(LoadDataEvent event, Emitter<AppState> emit) async {
    log("ON LOAD DATA, STATUS: ${state.status}");
    if (state.hasReachedMax) return;
    try {
      int page = (state.items.length / kLimit).ceil();
      log("page: $page");

      final issues = await repo.getData(query, page + 1);
      emit(issues.items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: Status.success,
              items: List.of(state.items)..addAll(issues.items),
              hasReachedMax: false));
    } catch (e) {
      log("ERROR: $e");
      emit(state.copyWith(status: Status.failure, errorMsg: e.toString()));
    }
  }

  // memulai query baru
  Future<void> _onNewQuery(NewQueryEvent event, Emitter<AppState> emit) async {
    log("ON NEW QUERY, STATUS: ${state.status}");

    // menampilkan circular indicator
    emit(state.copyWith(status: Status.loading));

    try {
      log("masuk initial state new issue");
      query = event.query; // set new query
      final issues = await repo.getData(query, 1);
      emit(state.copyWith(
          status: Status.success,
          items: issues.items,
          slicedItems: issues.items,
          hasReachedMax: false,
          totalItems: issues.totalCount,
          currentPage: 1,
          query: event.query
          // type: event.type
          ));
    } catch (e) {
      log("ERROR: $e");
      emit(state.copyWith(status: Status.failure, errorMsg: e.toString()));
    }
  }

  // load issue pada page tertentu
  Future<void> _onLoadDataPage(
      LoadDataPageEvent event, Emitter<AppState> emit) async {
    log("ON LOAD DATA PAGEE, STATUS: ${state.status}");

    if (state.hasReachedMax) {
      log("Reach max oi");
    }

    emit(state.copyWith(status: Status.loading));
    int _endAt = event.page * kLimit;
    int _startAt = _endAt - kLimit;

    // data sudah tersedia
    if (_endAt <= state.items.length || state.hasReachedMax) {
      log("data sudah tersedia");
      emit(state.copyWith(
          status: Status.success,
          slicedItems: state.items.sublist(
              _startAt >= 0 ? _startAt : 0,
              _endAt <= state.items.length ? _endAt : state.items.length),
          currentPage: event.page));
    }

    // data belum tersedia ; fetch dari API
    else {
      log("data belum tersedia");
      try {
        final issues = await repo.getData(query, event.page);
        var tempList = List.of(state.items);

        // baru tambahin hasil fetch
        tempList.addAll(issues.items);

        var tempSlicedList = tempList.sublist(_endAt - kLimit,
            _endAt <= tempList.length ? _endAt : tempList.length);

        log("startAt: $_startAt endAt: $_endAt current length: ${tempList.length}");

        emit(state.copyWith(
          status: Status.success,
          items: tempList,
          slicedItems: tempSlicedList,
          currentPage: event.page,
          hasReachedMax: _endAt > tempList.length,
        ));
      } catch (e) {
        log("ERROR: $e");
        emit(state.copyWith(status: Status.failure, errorMsg: e.toString()));
      }
    }
  }

  // pindah dari index ke lazy
  Future<void> _onIndexToLazy(
      IndexToLazyEvent event, Emitter<AppState> emit) async {
    log("INDEX TO LAZY, STATUS: ${state.status}");

    emit(state.copyWith(
        currentIdx: event.idx,
        currentPage: event.page,
        status: Status.success));
  }
}
