import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sejuta_cita_test/constants.dart';
import 'package:sejuta_cita_test/models/issue-response.dart';
import 'package:sejuta_cita_test/repository/issue-repository.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  // final _issueRepo = IssueRepo();
  Repo repo;
  String query;

  // initial state
  AppBloc(this.repo, this.query)
      : super(const AppState(slicedItems: [], items: [])) {
    on<LoadDataEvent>(_onLoadData); // TODO hapus aja kayaknya
    on<NewQueryEvent>(_onNewQuery);
    on<LoadDataPageEvent>(_onLoadDataPage);
    on<IndexToLazyEvent>(_onIndexToLazy);
    on<ChangeSearchTypeEvent>(_onChangeSearchType);
  }

  // ganti search type
  Future<void> _onChangeSearchType(
      ChangeSearchTypeEvent event, Emitter<AppState> emit) async {
    switch (event.type) {
      case SearchType.issues:
        {
          repo = IssueRepo();
        }
        break;

      case SearchType.repositories:
        {
          repo = RepositoryRepo();
        }
        break;

      default:
        {
          repo = UserRepo();
        }
        break;
    }
    emit(state.copyWith(type: event.type));
    add(NewQueryEvent(state.query));
  }

  // melanjutkan dari query yang sudah ada
  Future<void> _onLoadData(LoadDataEvent event, Emitter<AppState> emit) async {
    if (state.hasReachedMax) return;
    try {
      int page = state.items.length ~/ Constant.limit;
      log("page: $page");

      final issues = await repo.getData(query, page + 1);
      emit(issues.items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: Status.success,
              items: List.of(state.items)..addAll(issues.items),
              hasReachedMax: false));
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  // memulai query baru
  Future<void> _onNewQuery(NewQueryEvent event, Emitter<AppState> emit) async {
    // menampilkan circular indicator
    emit(state.copyWith(status: Status.loading));

    if (state.hasReachedMax) return;
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
      log('$e');
      emit(state.copyWith(status: Status.failure));
    }
  }

  // load issue pada page tertentu
  Future<void> _onLoadDataPage(
      LoadDataPageEvent event, Emitter<AppState> emit) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: Status.loading));
    int _endAt = event.page * Constant.limit;
    int _startAt = _endAt - Constant.limit;

    // data sudah tersedia
    if (_endAt <=
            state.items
                .length /*&&
        state.items[_startAt].state != "unknown" &&
        state.items[_endAt - 1].state != "unknown"*/
        ) {
      emit(state.copyWith(
          status: Status.success,
          slicedItems: state.items.sublist(_startAt, _endAt),
          currentPage: event.page));
    }

    // data belum tersedia ; fetch dari API
    else {
      try {
        final issues = await repo.getData(query, event.page);
        var tempList = List.of(state.items);

        // TODO bisa dijadiin fungsi juga parameternya list sama startAt
        // menangani indeks yang loncat / ga berurut
        // isi dulu bolongnya
        while (tempList.length < _startAt) {
          tempList.add(Item.emptyItem());
        }

        // baru tambahin hasil fetch
        tempList.addAll(issues.items);

        // TODO == unknown ini bisa dijadiin fungsi isUnknown
        // replace unknown data
        // if (tempList[_startAt].state == "unknown" &&
        //     tempList[_endAt - 1].state == "unknown") {
        //   log("masuk replace data baru");
        //   tempList.replaceRange(_startAt, _endAt, issues.items);
        // }

        var tempSlicedList = tempList.sublist(_endAt - Constant.limit, _endAt);

        log("startAt: $_startAt endAt: $_endAt current length: ${tempList.length}");

        emit(issues.items.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: Status.success,
                items: tempList,
                slicedItems: tempSlicedList,
                currentPage: event.page,
                hasReachedMax: false,
              ));
      } catch (e) {
        log("ERROR: $e");
        emit(state.copyWith(status: Status.failure));
      }
    }
  }

  // pindah dari index ke lazy
  Future<void> _onIndexToLazy(
      IndexToLazyEvent event, Emitter<AppState> emit) async {
    emit(state.copyWith(currentIdx: event.idx, currentPage: event.page));
  }
}
