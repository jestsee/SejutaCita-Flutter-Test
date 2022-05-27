import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../constants.dart';
import '../models/repository-response.dart';
import '../repository/repository-repository.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  final RepositoryRepo _RepositoryRepo;
  String query;

  // initial state
  RepositoryBloc(this._RepositoryRepo, this.query) : super(const RepositoryState(slicedItems: [], items: [])) {
    on<GetRepositoryEvent>(_onRepositoryFetched); // TODO hapus aja kayaknya
    on<GetNewRepositoryEvent>(_onNewRepositoryFetched);
    on<GetRepositoryIndexEvent>(_onRepositoryPageFetched);
    on<IndexToLazyEvent>(_onIndexToLazy);
  }

  // melanjutkan dari query yang sudah ada
  Future<void> _onRepositoryFetched(
      GetRepositoryEvent event, Emitter<RepositoryState> emit) async {
    if (state.hasReachedMax) return;
    try {
      int page = state.items.length ~/ Constant.LIMIT;
      log("page: $page");

      final Repositorys = await _RepositoryRepo.getRepositories(query, page + 1);
      emit(Repositorys.items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
          status: RepositoryStatus.success,
          items: List.of(state.items)..addAll(Repositorys.items),
          hasReachedMax: false));
    } catch (_) {
      emit(state.copyWith(status: RepositoryStatus.failure));
    }
  }

  // memulai query baru
  Future<void> _onNewRepositoryFetched(
      GetNewRepositoryEvent event, Emitter<RepositoryState> emit) async {
    // menampilkan circular indicator
    emit(state.copyWith(status: RepositoryStatus.loading));

    if (state.hasReachedMax) return;
    try {
      log("masuk initial state new Repository");
      query = event.query; // set new query
      final Repositorys = await _RepositoryRepo.getRepositories(query, 1);
      emit(state.copyWith(
          status: RepositoryStatus.success,
          items: Repositorys.items,
          slicedItems: Repositorys.items,
          // ambil semuanya
          hasReachedMax: false,
          totalItems: Repositorys.totalCount,
          currentPage: 1
      ));
    } catch (_) {
      emit(state.copyWith(status: RepositoryStatus.failure));
    }
  }

  // load Repository pada page tertentu
  Future<void> _onRepositoryPageFetched(
      GetRepositoryIndexEvent event, Emitter<RepositoryState> emit) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: RepositoryStatus.loading));
    int _endAt = event.page * Constant.LIMIT;
    int _startAt = _endAt - Constant.LIMIT;

    // data sudah tersedia
    if (_endAt <= state.items.length &&
        state.items[_startAt].state != "unknown" &&
        state.items[_endAt - 1].state != "unknown") {
      emit(state.copyWith(
          status: RepositoryStatus.success,
          slicedItems: state.items.sublist(_startAt, _endAt),
          currentPage: event.page));
    }

    // data belum tersedia ; fetch dari API
    else {
      try {
        final Repositories = await _RepositoryRepo.getRepositories(query, event.page);
        var tempList = List.of(state.items);

        // TODO bisa dijadiin fungsi juga parameternya list sama startAt
        // menangani indeks yang loncat / ga berurut
        // isi dulu bolongnya
        while (tempList.length < _startAt) {
          tempList.add(Item.emptyItem());
        }

        // baru tambahin hasil fetch
        tempList.addAll(Repositories.items);

        // TODO == unknown ini bisa dijadiin fungsi isUnknown
        // replace unknown data
        if (tempList[_startAt].state == "unknown" &&
            tempList[_endAt - 1].state == "unknown") {
          log("masuk replace data baru");
          tempList.replaceRange(_startAt, _endAt, Repositories.items);
        }

        var tempSlicedList = tempList.sublist(_endAt - Constant.LIMIT, _endAt);

        log("startAt: $_startAt endAt: $_endAt current length: ${tempList.length}");

        emit(Repositories.items.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
          status: RepositoryStatus.success,
          items: tempList,
          slicedItems: tempSlicedList,
          currentPage: event.page,
          hasReachedMax: false,
        ));
      } catch (e) {
        log("ERROR: $e");
        emit(state.copyWith(status: RepositoryStatus.failure));
      }
    }
  }

  // pindah dari index ke lazy
  Future<void> _onIndexToLazy(
      IndexToLazyEvent event, Emitter<RepositoryState> emit) async {
    emit(state.copyWith(currentIdx: event.idx, currentPage: event.page));
  }
}
